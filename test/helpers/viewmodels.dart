part of 'test_helpers.dart';

OnBoardingViewModel getAndRegisterOnBoardingViewModel() {
  _removeRegistrationIfExists<OnBoardingViewModel>();
  final service = MockOnBoardingViewModel();
  locator.registerSingleton<OnBoardingViewModel>(service);
  return service;
}
