import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/services/notification_service.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService $navigationService = locator<NavigationService>();

  wait() async {
    await Future.delayed(Duration(seconds: 1));
    await locator<NotificationService>().init();
    await locator<BrandLocalDataSource>().init();
    await locator<SubscriptionLocalDataSource>().init();
    $navigationService.replaceWith(Routes.onBoardingView);
  }
}
