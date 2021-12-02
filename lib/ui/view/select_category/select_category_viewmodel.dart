import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/models/category.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';

final selectCategoryViewModelCNP = ChangeNotifierProvider(
  (ref) => SelectCategoryViewModel(ref),
  name: 'SelectCategoryViewModel',
);

class SelectCategoryViewModel extends BaseViewModel with $SharedVariables {
  List<Category> get categories => Category.categories;

  final Ref _ref;

  SelectCategoryViewModel(this._ref);

  @override
  Ref get ref => _ref;

  pop({String? category}) {
    Get.back(result: category, id: 2);
    // $navigationService.back(id: 2, result: category);
  }
}
