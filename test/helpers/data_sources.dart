part of 'test_helpers.dart';

BrandLocalDataSource getAndRegisterBrandLocalDataSource() {
  _removeRegistrationIfExists<BrandLocalDataSource>();
  final service = MockBrandLocalDataSource();
  locator.registerSingleton<BrandLocalDataSource>(service);
  return service;
}

BrandRemoteDataSource getAndRegisterBrandRemoteDataSource() {
  _removeRegistrationIfExists<BrandRemoteDataSource>();
  final service = MockBrandRemoteDataSource();
  locator.registerSingleton<BrandRemoteDataSource>(service);
  return service;
}

SubscriptionLocalDataSource getAndRegisterSubscriptionLocalDataSource() {
  _removeRegistrationIfExists<SubscriptionLocalDataSource>();
  final service = MockSubscriptionLocalDataSource();
  locator.registerSingleton<SubscriptionLocalDataSource>(service);
  return service;
}

SubscriptionRemoteDataSource getAndRegisterSubscriptionRemoteDataSource() {
  _removeRegistrationIfExists<SubscriptionRemoteDataSource>();
  final service = MockSubscriptionRemoteDataSource();
  locator.registerSingleton<SubscriptionRemoteDataSource>(service);
  return service;
}
