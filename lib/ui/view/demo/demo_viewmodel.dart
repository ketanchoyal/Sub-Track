// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';

class DemoViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  navigate() => navigationService.navigateTo(Routes.startUpView);
}
