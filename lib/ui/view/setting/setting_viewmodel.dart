import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';

final settingViewModelCNP = ChangeNotifierProvider(
  (ref) => SettingViewModel(ref),
  name: 'SettingViewModel',
);

class SettingViewModel extends BaseViewModel with $SharedVariables {
  SettingViewModel(this._ref);

  final ProviderRefBase _ref;

  @override
  ProviderRefBase get ref => _ref;

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
