import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/models/category.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class SelectCategoryViewModel extends BaseViewModel with $SharedVariables {
  List<Category> get categories => Category.categories;

  pop({String? category}) => $navigationService.back(id: 2, result: category);
}
