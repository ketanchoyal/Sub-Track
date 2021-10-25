// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sub_track/app/app.router.dart';
// import 'package:sub_track/ui/shared/shared.dart';
// import 'package:sub_track/ui/view/login/login_viewmodel.dart';
// import 'package:sub_track/ui/view/login/login_view.formx.dart';

// import '../helpers/test_helpers.dart';

// LoginViewModel _getModel() => LoginViewModel();

// void main() {
//   group('LoginViewModelTest -', () {
//     setUp(() async => await registerMocks());
//     tearDown(() => unregisterAll());

//     group('Email Validation -', () {
//       test(
//         'When Email is invalid TextFieldType should be ERROR',
//         () async {
//           final model = _getModel();
//           model.formValueMap[EmailValueKey] = "invalidEmail";
//           model.setFormStatus();

//           expect(model.emailTextFieldType, TextFieldType.ERROR);
//         },
//       );
//       test(
//         'When Email is valid TextFieldType should be VALID',
//         () async {
//           final model = _getModel();
//           model.formValueMap[EmailValueKey] = "validemail@gmail.com";
//           model.setFormStatus();

//           expect(model.emailTextFieldType, TextFieldType.VALID);
//         },
//       );
//     });

//     group('Password Validation -', () {
//       test(
//         'When Password is empty TextFieldType should be ERROR',
//         () async {
//           final model = _getModel();
//           model.formValueMap[PasswordValueKey] = "   ";
//           model.formValueMap[EmailValueKey] = "validemail@gmail.com";
//           model.setFormStatus();
//           await model.saveData();

//           expect(model.passwordTextFieldType, TextFieldType.ERROR);

//           verifyNever(model.runAuthentication());
//         },
//       );
//       test(
//         'When Password is null TextFieldType should be ERROR',
//         () async {
//           await getAndRegisterFirebaseAuthenticationService();
//           final model = _getModel();
//           model.formValueMap[PasswordValueKey] = null;
//           model.formValueMap[EmailValueKey] = "validemail@gmail.com";
//           model.setFormStatus();
//           await model.saveData();

//           expect(model.passwordTextFieldType, TextFieldType.ERROR);

//           // verifyNever(model.runAuthentication());
//         },
//       );
//     });

//     group('Login -', () {
//       test('Login with INVALID email & Password', () async {
//         String email = "invalidemailcom";
//         String password = "thisIsPassword";
//         var firebaseAuth = await getAndRegisterFirebaseAuthenticationService(
//           successFullLogin: false,
//           email: email,
//           password: password,
//         );
//         // var subscriptionRepo = getAndRegisterSubscriptionRepo();
//         getAndRegisterNavigationService();
//         final model = _getModel();

//         model.formValueMap[EmailValueKey] = email;
//         model.formValueMap[PasswordValueKey] = password;

//         await model.saveData();

//         verifyNever(
//             firebaseAuth.loginWithEmail(email: email, password: password));
//       });

//       test('Login with VALID email & Password', () async {
//         String email = "validemail@gmail.com";
//         String password = "thisIsPassword";
//         var firebaseAuth = await getAndRegisterFirebaseAuthenticationService(
//           successFullLogin: true,
//           email: email,
//           password: password,
//         );
//         final model = _getModel();

//         model.formValueMap[EmailValueKey] = email;
//         model.formValueMap[PasswordValueKey] = password;

//         model.setFormStatus();
//         await model.saveData();

//         verify(firebaseAuth.loginWithEmail(email: email, password: password));

//         expect(model.result.hasError, false);
//         expect(model.isNewUser, false);
//         expect(model.successRoute, Routes.homeView);
//         expect(firebaseAuth.hasUser, true);
//         // verify(subscriptionRepo.cacheSubscriptions());
//         // verify(navigationService.clearStackAndShow(model.successRoute))
//         //     .called(1);
//       });

//       test('When Login is successful then subscriptions are cached', () async {
//         String email = "validemail@gmail.com";
//         String password = "thisIsPassword";
//         await getAndRegisterFirebaseAuthenticationService(
//           successFullLogin: true,
//           email: email,
//           password: password,
//         );
//         var subscriptionRepo = await getAndRegisterSubscriptionRepo();
//         // getAndRegisterNavigationService();
//         final model = _getModel();

//         model.formValueMap[EmailValueKey] = email;
//         model.formValueMap[PasswordValueKey] = password;

//         model.setFormStatus();
//         await model.saveData();

//         verify(subscriptionRepo.cacheSubscriptions());
//         // verify(navigationService.clearStackAndShow(model.successRoute))
//         //     .called(1);
//       });

//       test('When Login is successful then user is navigated to success route',
//           () async {
//         String email = "validemail@gmail.com";
//         String password = "thisIsPassword";
//         var navigationService =
//             await getAndRegisterNavigationService(route: Routes.homeView);
//         await getAndRegisterFirebaseAuthenticationService(
//           successFullLogin: true,
//           email: email,
//           password: password,
//         );
//         await getAndRegisterSnackbarService();
//         var subscriptionRepo = await getAndRegisterSubscriptionRepo();
//         final model = _getModel();

//         model.formValueMap[EmailValueKey] = email;
//         model.formValueMap[PasswordValueKey] = password;

//         model.setFormStatus();
//         await model.saveData();

//         await subscriptionRepo.cacheSubscriptions();
//         await model.runAfterSuccessfullAuth();

//         verify(navigationService.clearStackAndShow(model.successRoute));
//       });
//     });
//   });
// }
