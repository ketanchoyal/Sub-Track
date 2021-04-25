// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/brand/brand_remote.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_remote.dart';
import 'package:sub_track/core/repository/brand/brand_repo.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/core/services/connectivity_service.dart';
import 'package:sub_track/core/services/file_service.dart';
import 'package:sub_track/core/services/notification_service.dart';
import 'package:sub_track/core/services/stoppable_services.dart';
import 'package:sub_track/core/services/subscription_service.dart';
import 'package:sub_track/core/services/url_launch_service.dart';

import '../core/services/brand_service.dart';
import '../ui/services/ui_services.dart';
import '../ui/view/on_boarding/on_boarding_viewmodel.dart';

final locator = StackedLocator.instance;

setupLocator() async {
  // Stacked
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerSingleton(FirebaseAuthenticationService());

  // **************************************************************************
  // App Dependencies
  // **************************************************************************
  // Services
  locator.registerSingleton<NotificationService>(NotificationServiceImpl());
  locator.registerSingleton<FileService>(FileServiceImpl());
  locator.registerLazySingleton<StoppableService>(() => ConnectivityService());
  locator.registerSingleton<BrandService>(BrandServiceImpl());
  locator.registerSingleton<SubscriptionService>(SubscriptionServiceImpl());
  locator.registerSingleton(UrlLaunchService());

  locator.registerLazySingleton<HiveInterface>(() => Hive);

  // Data Sources
  locator.registerSingleton<BrandLocalDataSource>(BrandLocalDataSourceImpl());
  locator.registerSingleton<BrandRemoteDataSource>(BrandRemoteDataSourceImpl());
  locator.registerSingleton<SubscriptionLocalDataSource>(
      SubscriptionLocalDataSourceImpl());
  locator.registerSingleton<SubscriptionRemoteDataSource>(
      SubscriptionRemoteDataSourceImpl());

  // Repositories
  locator.registerSingleton<BrandRepo>(BrandRepoImpl());
  locator.registerSingleton<SubscriptionRepo>(SubscriptionRepoImpl());

  locator.registerSingleton<CalculationService>(CalculationServiceImpl());

  // **************************************************************************
  // Front End
  // **************************************************************************
  locator.registerLazySingleton(() => UIServices());

  //View Models
  locator.registerSingleton(OnBoardingViewModel());
}
