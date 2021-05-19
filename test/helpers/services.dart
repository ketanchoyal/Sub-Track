part of 'test_helpers.dart';

Future<NavigationService> getAndRegisterNavigationService(
    {String? route}) async {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  // when(service.clearStackAndShow(route))
  //     .thenAnswer((realInvocation) async => null);
  locator.registerSingleton<NavigationService>(service);
  return service;
}

DialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

Future<SnackbarService> getAndRegisterSnackbarService() async {
  _removeRegistrationIfExists<SnackbarService>();
  final service = MockSnackbarService();
  when(service.showCustomSnackBar()).thenAnswer((_) async => null);
  locator.registerSingleton<SnackbarService>(service);
  return service;
}

BottomSheetService getAndRegisterBottomSheetService() {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();
  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

Future<FirebaseAuthenticationService>
    getAndRegisterFirebaseAuthenticationService({
  bool? successFullLogin,
  bool? successFullRegister,
  String? email,
  String? password,
}) async {
  _removeRegistrationIfExists<FirebaseAuthenticationService>();
  final service = MockFirebaseAuthenticationService();
  if (successFullLogin != null) {
    when(service.loginWithEmail(
      email: email,
      password: password,
    )).thenAnswer((_) async => successFullLogin
        ? FirebaseAuthenticationResult(user: FakeUser())
        : FirebaseAuthenticationResult.error(errorMessage: "Error"));
    when(service.hasUser).thenReturn(successFullLogin);
  }

  if (successFullRegister != null) {
    when(service.createAccountWithEmail(
      email: email,
      password: password,
    )).thenAnswer((_) async => successFullRegister
        ? FirebaseAuthenticationResult(user: FakeUser())
        : FirebaseAuthenticationResult.error(errorMessage: "Error"));
    when(service.hasUser).thenReturn(successFullRegister);
  }
  locator.registerSingleton<FirebaseAuthenticationService>(service);
  return service;
}

NotificationService getAndRegisterNotificationService() {
  _removeRegistrationIfExists<NotificationService>();
  final service = MockNotificationService();
  locator.registerSingleton<NotificationService>(service);
  return service;
}

FileService getAndRegisterFileService() {
  _removeRegistrationIfExists<FileService>();
  final service = MockFileService();
  locator.registerSingleton<FileService>(service);
  return service;
}

StoppableService getAndRegisterStoppableService() {
  _removeRegistrationIfExists<StoppableService>();
  final service = MockConnectivityService();
  locator.registerSingleton<StoppableService>(service);
  return service;
}

BrandService getAndRegisterBrandService() {
  _removeRegistrationIfExists<BrandService>();
  final service = MockBrandService();
  locator.registerSingleton<BrandService>(service);
  return service;
}

SubscriptionService getAndRegisterSubscriptionService() {
  _removeRegistrationIfExists<SubscriptionService>();
  final service = MockSubscriptionService();
  locator.registerSingleton<SubscriptionService>(service);
  return service;
}

UrlLaunchService getAndRegisterUrlLaunchService() {
  _removeRegistrationIfExists<UrlLaunchService>();
  final service = MockUrlLaunchService();
  locator.registerSingleton<UrlLaunchService>(service);
  return service;
}

CalculationService getAndRegisterCalculationService() {
  _removeRegistrationIfExists<CalculationService>();
  final service = MockCalculationService();
  locator.registerSingleton<CalculationService>(service);
  return service;
}
