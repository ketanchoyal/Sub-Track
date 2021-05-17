import 'package:hive/hive.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/brand/brand_remote.dart';
import 'package:hive/src/hive_impl.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_remote.dart';
import 'package:sub_track/core/repository/brand/brand_repo.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/core/services/connectivity_service.dart';
import 'package:sub_track/core/services/file_service.dart';
import 'package:sub_track/core/services/notification_service.dart';
import 'package:sub_track/core/services/stoppable_services.dart';
import 'package:sub_track/core/services/firebase/subscription_service.dart';
import 'package:sub_track/core/services/url_launch_service.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/view/on_boarding/on_boarding_viewmodel.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test_helpers.mocks.dart';

part 'services.dart';
part 'data_sources.dart';
part 'repositories.dart';
part 'viewmodels.dart';
part 'others.dart';

@GenerateMocks(
  [],
  customMocks: [
    // Stacked
    MockSpec<NavigationService>(returnNullOnMissingStub: true),
    MockSpec<DialogService>(returnNullOnMissingStub: true),
    MockSpec<SnackbarService>(returnNullOnMissingStub: true),
    MockSpec<BottomSheetService>(returnNullOnMissingStub: true),
    MockSpec<FirebaseAuthenticationService>(returnNullOnMissingStub: true),

    // **************************************************************************
    // App Dependencies
    // **************************************************************************
    // Services
    MockSpec<NotificationService>(returnNullOnMissingStub: true),
    MockSpec<FileService>(returnNullOnMissingStub: true),
    MockSpec<ConnectivityService>(
      returnNullOnMissingStub: true,
    ),
    MockSpec<BrandService>(returnNullOnMissingStub: true),
    MockSpec<SubscriptionService>(returnNullOnMissingStub: true),
    MockSpec<UrlLaunchService>(returnNullOnMissingStub: true),

    MockSpec<HiveInterface>(returnNullOnMissingStub: true),

    // Data Sources
    MockSpec<BrandLocalDataSource>(returnNullOnMissingStub: true),
    MockSpec<BrandRemoteDataSource>(returnNullOnMissingStub: true),
    MockSpec<SubscriptionLocalDataSource>(returnNullOnMissingStub: true),
    MockSpec<SubscriptionRemoteDataSource>(returnNullOnMissingStub: true),

    // Repositories
    MockSpec<BrandRepo>(returnNullOnMissingStub: true),
    MockSpec<SubscriptionRepo>(returnNullOnMissingStub: true),

    MockSpec<CalculationService>(returnNullOnMissingStub: true),

    // **************************************************************************
    // Front End
    // **************************************************************************
    MockSpec<UIServices>(returnNullOnMissingStub: true),

    //View Models
    MockSpec<OnBoardingViewModel>(returnNullOnMissingStub: true),
  ],
)
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

registerMocks() async {
  getAndRegisterNavigationService();
  getAndRegisterDialogService();
  getAndRegisterSnackbarService();
  getAndRegisterBottomSheetService();
  getAndRegisterFirebaseAuthenticationService();

  getAndRegisterNotificationService();
  getAndRegisterFileService();
  getAndRegisterStoppableService();
  getAndRegisterBrandService();
  getAndRegisterSubscriptionService();
  getAndRegisterUrlLaunchService();

  getAndRegisterHiveInterface();

  getAndRegisterBrandLocalDataSource();
  getAndRegisterBrandRemoteDataSource();
  getAndRegisterSubscriptionLocalDataSource();
  getAndRegisterSubscriptionRemoteDataSource();

  getAndRegisterBrandRepo();
  getAndRegisterSubscriptionRepo();

  getAndRegisterCalculationService();

  getAndRegisterUIServices();

  getAndRegisterOnBoardingViewModel();
}

void unregisterMocks() {
  locator.reset(dispose: true);
}
