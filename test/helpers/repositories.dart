part of 'test_helpers.dart';

BrandRepo getAndRegisterBrandRepo() {
  _removeRegistrationIfExists<BrandRepo>();
  final service = MockBrandRepo();
  locator.registerSingleton<BrandRepo>(service);
  return service;
}

Future<SubscriptionRepo> getAndRegisterSubscriptionRepo() async {
  _removeRegistrationIfExists<SubscriptionRepo>();
  final service = MockSubscriptionRepo();
  when(await service.cacheSubscriptions()).thenAnswer((_) async => null);
  locator.registerSingleton<SubscriptionRepo>(service);
  return service;
}
