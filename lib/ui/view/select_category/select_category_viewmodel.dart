import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';

class SelectCategoryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  pop() => _navigationService.back(id: 2);
}
