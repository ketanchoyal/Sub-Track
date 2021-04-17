import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/services/ui_services.dart';

mixin $SharedVariables on BaseViewModel {
  NavigationService get $navigationService => locator<NavigationService>();
  UIServices get $uiServices => locator<UIServices>();
}
