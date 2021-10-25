import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/services/auth_service.dart';
import 'package:sub_track/core/services/notification_service.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';

final startupViewModelCNP =
    ChangeNotifierProvider.autoDispose<StartUpViewModel>(
  (ref) => StartUpViewModel(ref),
  name: 'StartUpViewModel',
);

class StartUpViewModel extends BaseViewModel {
  final ProviderRefBase _ref;
  StartUpViewModel(this._ref);

  NavigationService get _navigationService => _ref.read(navigationServiceP);

  wait() async {
    await Future.delayed(Duration(seconds: 1));
    if (!kIsWeb) await _ref.read(notificationServiceP).init();
    await _ref.read(brandLocalDataStorageP).init();
    await _ref.read(subscriptionLocalDataSourceP).init();
    await _checkIfLoggedIn();
  }

  _checkIfLoggedIn() async {
    FirebaseAuthenticationService firebaseAuthenticationService =
        _ref.read(firebaseAuthServiceP);

    if (firebaseAuthenticationService.hasUser)
      _navigationService.clearStackAndShow(Routes.homeView);
    else
      _navigationService.replaceWith(Routes.onBoardingView);
  }
}
