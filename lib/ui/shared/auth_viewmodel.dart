import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/snackbar_ui.dart';

abstract class AuthenticationViewModel extends FormViewModel
    with $SharedVariables {
  final firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final _snackbarService = locator<SnackbarService>();

  final String successRoute;
  AuthenticationViewModel({required this.successRoute});

  @override
  void setFormStatus() {}

  Future<FirebaseAuthenticationResult> runAuthentication();

  Future saveData() async {
    try {
      final result = await runBusyFuture(runAuthentication());
      _handleAuthenticationResponse(result);
    } catch (e) {}
  }

  Future<void> useGoogleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithGoogle();
    _handleAuthenticationResponse(result);
  }

  Future<void> useAnonymousLogin() async {
    final result = await firebaseAuthenticationService.loginAnonymously();
    _handleAuthenticationResponse(result);
  }

  Future<void> useAppleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithApple(
      appleClientId: '',
      appleRedirectUri:
          'https://sub-track-b7ad4.firebaseapp.com/__/auth/handler',
    );
    _handleAuthenticationResponse(result);
  }

  /// Checks if the result has an error. If it doesn't we navigate to the success view
  /// else we show the friendly validation message.
  void _handleAuthenticationResponse(FirebaseAuthenticationResult authResult) {
    if (!authResult.hasError) {
      // navigate to success route
      _snackbarService.showCustomSnackBar(
        message: "Logged in",
        duration: Duration(seconds: 4),
        variant: SnackbarType.Success,
        title: "Welcome, ${(authResult.user!.displayName) ?? ""}",
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
