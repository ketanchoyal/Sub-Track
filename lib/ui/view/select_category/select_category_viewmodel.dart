import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';

class SelectCategoryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  pop({String? category}) => _navigationService.back(id: 2, result: category);
}
