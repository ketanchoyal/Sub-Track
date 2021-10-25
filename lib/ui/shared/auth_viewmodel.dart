import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/auth_service.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/snackbar_ui.dart';

import 'base_viewmodel.dart';

abstract class AuthenticationViewModel extends FormViewModel
    with $SharedVariables {
  final ProviderRefBase _ref;
  AuthenticationViewModel(
    this._ref, {
    required this.successRoute,
    required this.isNewUser,
  });

  @override
  ProviderRefBase get ref => _ref;

  FirebaseAuthenticationService get firebaseAuthenticationService =>
      _ref.read(firebaseAuthServiceP);
  SnackbarService get _snackbarService => _ref.read(snackbarServiceP);

  SubscriptionRepo get _subscriptionRepo => _ref.read(subscriptionRepoP);

  final String successRoute;
  final bool isNewUser;
  late final FirebaseAuthenticationResult result;

  @override
  void setFormStatus() {}

  Future<void> runAfterSuccessfullAuth() async {}

  Future<FirebaseAuthenticationResult> runAuthentication();

  Future<void> saveData() async {
    try {
      result = await runBusyFuture(runAuthentication());
      await _handleAuthenticationResponse(result);
    } catch (e) {}
  }

  Future<void> useGoogleAuthentication() async {
    result = await firebaseAuthenticationService.signInWithGoogle();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useAnonymousLogin() async {
    result = await firebaseAuthenticationService.loginAnonymously();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useAppleAuthentication() async {
    result = await firebaseAuthenticationService.signInWithApple(
      appleClientId: '',
      appleRedirectUri:
          'https://sub-track-b7ad4.firebaseapp.com/__/auth/handler',
    );
    await _handleAuthenticationResponse(result);
  }

  /// Checks if the result has an error. If it doesn't we navigate to the success view
  /// else we show the friendly validation message.
  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult) async {
    if (!authResult.hasError) {
      // navigate to success route
      if (!isNewUser) {
        _snackbarService.showCustomSnackBar(
          message: "Please wait while we look for your saved subscriptions",
          duration: Duration(seconds: 4),
          variant: SnackbarType.Success,
        );
        await _subscriptionRepo.cacheSubscriptions();
      }
      _snackbarService.showCustomSnackBar(
        // message: "Logged in",
        duration: Duration(seconds: 4),
        variant: SnackbarType.Success,
        message:
            "Welcome, ${(authResult.user!.displayName) ?? "Anonymous User"}",
      );
      await runAfterSuccessfullAuth();
      $navigationService.clearStackAndShow(successRoute);
    } else {
      setValidationMessage(authResult.errorMessage);
      _snackbarService.showCustomSnackBar(
        message: authResult.errorMessage ?? "",
        duration: Duration(seconds: 4),
        variant: SnackbarType.Error,
        title: "Something went wrong",
      );
      notifyListeners();
    }
  }
}

/// Provides functionality to reduce the code required in order to move user input
/// into the [ViewModel]
abstract class FormViewModel extends BaseViewModel {
  bool _showValidation = false;
  bool get showValidation => _showValidation;

  String? _validationMessage;
  String? get validationMessage => _validationMessage;

  /// Stores the mapping of the form key to the value entered by the user
  Map<String, dynamic> formValueMap = Map<String, dynamic>();

  void setValidationMessage(String? value) {
    _validationMessage = value;
    _showValidation = _validationMessage?.isNotEmpty ?? false;
  }

  void setData(Map<String, dynamic> data) {
    // Save the data from the controllers
    formValueMap = data;

    // Reset the form status
    setValidationMessage(null);

    // Set the new form status
    setFormStatus();

    // Rebuild the UI
    notifyListeners();
  }

  /// Called after the [formValueMap] has been updated and allows you to set
  /// values relating to the forms status.
  void setFormStatus();
}
