import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_view.formx.dart';
import 'package:sub_track/ui/view/login/login_view.form.dart';
import 'package:sub_track/ui/view/register/register_viewmodel.dart';

import '../helpers/test_helpers.dart';

RegisterViewModel _getModel() => RegisterViewModel();
void main() {
  group('RegisterViewModelTest -', () {
    setUp(() async => await registerMocks());
    tearDown(() => unregisterMocks());

    group('Email Validation -', () {
      test(
        'When Email is invalid TextFieldType should be ERROR',
        () async {
          final model = _getModel();
          model.formValueMap[EmailValueKey] = "invalidEmail";
          model.formValueMap[NameValueKey] = "thisIsName";
          model.formValueMap[PasswordValueKey] = "thisIsPassword";
          model.setFormStatus();

          expect(model.emailTextFieldType, TextFieldType.ERROR);
        },
      );
      test(
        'When Email is valid TextFieldType should be VALID',
        () async {
          final model = _getModel();
          model.formValueMap[EmailValueKey] = "validemail@gmail.com";
          model.formValueMap[NameValueKey] = "thisIsName";
          model.formValueMap[PasswordValueKey] = "thisIsPassword";
          model.setFormStatus();

          expect(model.emailTextFieldType, TextFieldType.VALID);
        },
      );
    });

    group('Password Validation -', () {
      test(
        'When Password is empty TextFieldType should be ERROR',
        () async {
          final model = _getModel();
          model.formValueMap[PasswordValueKey] = "   ";
          model.formValueMap[EmailValueKey] = "validemail@gmail.com";
          model.formValueMap[NameValueKey] = "thisIsName";
          model.setFormStatus();
          await model.saveData();

          expect(model.passwordTextFieldType, TextFieldType.ERROR);

          verifyNever(model.runAuthentication());
        },
      );
      test(
        'When Password is null TextFieldType should be ERROR',
        () async {
          await getAndRegisterFirebaseAuthenticationService();
          final model = _getModel();
          model.formValueMap[PasswordValueKey] = null;
          model.formValueMap[EmailValueKey] = "validemail@gmail.com";
          model.formValueMap[NameValueKey] = "thisIsName";
          model.setFormStatus();
          await model.saveData();

          expect(model.passwordTextFieldType, TextFieldType.ERROR);

          // verifyNever(model.runAuthentication());
        },
      );
    });

    group('Register -', () {
      test('Register with INVALID email & Password', () async {
        String email = "invalidemailcom";
        String password = "thisIsPassword";
        String name = "thisIsName";
        var firebaseAuth = await getAndRegisterFirebaseAuthenticationService(
          successFullRegister: false,
          email: email,
          password: password,
        );
        // var subscriptionRepo = getAndRegisterSubscriptionRepo();
        // final navigationService = getAndRegisterNavigationService();
        final model = _getModel();

        model.formValueMap[EmailValueKey] = email;
        model.formValueMap[PasswordValueKey] = password;
        model.formValueMap[NameValueKey] = name;

        model.setFormStatus();
        await model.saveData();

        verifyNever(firebaseAuth.createAccountWithEmail(
            email: email, password: password));
      });
      test('Register with VALID email & Password and not null name', () async {
        String email = "validemail@gmail.com";
        String password = "thisIsPassword";
        String name = "thisIsName";
        var firebaseAuth = await getAndRegisterFirebaseAuthenticationService(
          successFullRegister: true,
          email: email,
          password: password,
        );

        final model = _getModel();

        model.formValueMap[EmailValueKey] = email;
        model.formValueMap[PasswordValueKey] = password;
        model.formValueMap[NameValueKey] = name;

        model.setFormStatus();
        await model.saveData();

        verify(firebaseAuth.createAccountWithEmail(
            email: email, password: password));

        expect(model.result.hasError, false);
        expect(model.isNewUser, true);
        expect(model.successRoute, Routes.homeView);
        expect(firebaseAuth.hasUser, true);
      });
      test(
          'When Register is successful then user is navigated to success route',
          () async {
        String email = "validemail@gmail.com";
        String password = "thisIsPassword";
        String name = "thisIsName";
        var navigationService =
            await getAndRegisterNavigationService(route: Routes.homeView);
        await getAndRegisterFirebaseAuthenticationService(
          successFullRegister: true,
          email: email,
          password: password,
        );
        await getAndRegisterSnackbarService();
        var subscriptionRepo = await getAndRegisterSubscriptionRepo();
        final model = _getModel();

        model.formValueMap[EmailValueKey] = email;
        model.formValueMap[PasswordValueKey] = password;
        model.formValueMap[NameValueKey] = name;

        model.setFormStatus();
        await model.saveData();
        await model.runAfterSuccessfullAuth();

        verify(navigationService.clearStackAndShow(model.successRoute));
        // print(navigationService.currentRoute);
      });
    });
  });
}
