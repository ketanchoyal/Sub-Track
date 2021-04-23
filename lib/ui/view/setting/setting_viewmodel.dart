import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class SettingViewModel extends BaseViewModel with $SharedVariables {
  bool get isAnonymous =>
      $firebaseAuthenticationService.currentUser?.isAnonymous ?? true;
  bool get isLoggedIn => $firebaseAuthenticationService.hasUser;
  pop() {
    $navigationService.back();
  }

  navigateToSignIn() {
    $navigationService.navigateTo(Routes.loginView);
  }

  signOut() {
    $firebaseAuthenticationService.logout();
  }
}
