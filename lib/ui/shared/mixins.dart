import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';

mixin $SharedVariables on BaseViewModel {
  NavigationService get $navigationService => locator<NavigationService>();
}
