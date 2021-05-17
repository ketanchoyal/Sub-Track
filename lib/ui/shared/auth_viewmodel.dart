import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/snackbar_ui.dart';

abstract class AuthenticationViewModel extends FormViewModel
    with $SharedVariables {
  FirebaseAuthenticationService get firebaseAuthenticationService =>
      locator<FirebaseAuthenticationService>();
  SnackbarService get _snackbarService => locator<SnackbarService>();

  SubscriptionRepo get _subscriptionRepo => locator<SubscriptionRepo>();

  final String successRoute;
  final bool isNewUser;
  late final FirebaseAuthenticationResult result;
  AuthenticationViewModel(
      {required this.successRoute, required this.isNewUser});

  @override
  void setFormStatus() {}

  Future<FirebaseAuthenticationResult> runAuthentication();

  Future saveData() async {
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
  _handleAuthenticationResponse(FirebaseAuthenticationResult authResult) async {
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
