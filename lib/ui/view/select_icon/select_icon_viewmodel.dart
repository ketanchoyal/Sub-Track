import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';

class SelectIconViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void pop() {
    _navigationService.back(id: 2);
  }
}
