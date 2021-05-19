import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/view/startup/startup_viewmodel.dart';

import '../helpers/test_helpers.dart';

StartUpViewModel _getModel() => StartUpViewModel();

void main() {
  group('StartupViewmodelTest -', () {
    setUp(() async => await registerMocks());
    tearDown(() => unregisterMocks());

    group('Run Statup Logic -', () {
      test(
        'When we have NO loggedIn User, User should navigate to Onboarding Route',
        () async {
          var navigationService = await getAndRegisterNavigationService();
          getAndRegisterFirebaseAuthenticationService(
              successFullLogin: false, successFullRegister: false);
          final model = _getModel();
          await model.wait();

          verify(navigationService.replaceWith(Routes.onBoardingView));
        },
      );
      test(
        'When we have loggedIn User, User should navigate to Home Route',
        () async {
          var navigationService = await getAndRegisterNavigationService();
          await getAndRegisterFirebaseAuthenticationService(
              successFullLogin: true);
          final model = _getModel();
          await model.wait();

          verify(navigationService.clearStackAndShow(Routes.homeView));
        },
      );
    });
  });
}
