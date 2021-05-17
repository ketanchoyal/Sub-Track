import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/view/login/login_viewmodel.dart';
import 'package:sub_track/ui/view/login/login_view.form.dart';

import '../helpers/test_helpers.dart';

LoginViewModel _getModel() => LoginViewModel();

void main() {
  group('LoginViewModelTest -', () {
    setUp(() async => await registerMocks());
    tearDown(() => unregisterMocks());

    group('Email Validation -', () {
      test(
        'When Email is invalid TextFieldType should be ERROR',
        () async {
          final model = _getModel();
          model.formValueMap[EmailValueKey] = "invalidEmail";
          model.setFormStatus();

          expect(model.emailTextFieldType, TextFieldType.ERROR);
        },
      );
      test(
        'When Email is valid TextFieldType should be VALID',
        () async {
          final model = _getModel();
          model.formValueMap[EmailValueKey] = "validemail@gmail.com";
          model.setFormStatus();

          expect(model.emailTextFieldType, TextFieldType.VALID);
        },
      );
    });

    group('Login -', () {
      test('Login with VALID email & Password', () async {
        String email = "validemail@gmail.com";
        String password = "thisIsPassword";
        await getAndRegisterFirebaseAuthenticationService(
          successFullLogin: true,
          email: email,
          password: password,
        );
        var subscriptionRepo = getAndRegisterSubscriptionRepo();
        final navigationService = getAndRegisterNavigationService();
        final model = _getModel();

        model.formValueMap[EmailValueKey] = email;
        model.formValueMap[PasswordValueKey] = password;

        await model.saveData();

        printOnFailure(model.result.user!.displayName!);

        expect(model.result.hasError, false);
        expect(model.successRoute, Routes.homeView);
        verify(subscriptionRepo.cacheSubscriptions());
        verify(navigationService.clearStackAndShow(model.successRoute));
      });

      test('Login with INVALID email & Password', () async {
        String email = "invalidemailcom";
        String password = "thisIsPassword";
        await getAndRegisterFirebaseAuthenticationService(
          successFullLogin: false,
          email: email,
          password: password,
        );
        // var subscriptionRepo = getAndRegisterSubscriptionRepo();
        // final navigationService = getAndRegisterNavigationService();
        final model = _getModel();

        model.formValueMap[EmailValueKey] = email;
        model.formValueMap[PasswordValueKey] = password;

        await model.saveData();

        expect(model.result.hasError, true);
      });
    });
  });
}
