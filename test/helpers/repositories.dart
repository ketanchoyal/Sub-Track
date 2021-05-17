part of 'test_helpers.dart';

BrandRepo getAndRegisterBrandRepo() {
  _removeRegistrationIfExists<BrandRepo>();
  final service = MockBrandRepo();
  locator.registerSingleton<BrandRepo>(service);
  return service;
}

SubscriptionRepo getAndRegisterSubscriptionRepo() {
  _removeRegistrationIfExists<SubscriptionRepo>();
  final service = MockSubscriptionRepo();
  locator.registerSingleton<SubscriptionRepo>(service);
  return service;
}
