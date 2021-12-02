import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';

final addSubViewModelCNP = ChangeNotifierProvider(
  (ref) => AddSubViewModel(ref),
  name: 'AddSubViewModel',
);

class AddSubViewModel extends BaseViewModel with $SharedVariables {
  final Ref _ref;

  AddSubViewModel(this._ref);

  @override
  Ref get ref => _ref;

  BrandService get _brandService => _ref.read(brandServiceP);

  String? _searchKeyword;

  searchKeyword(String? value) {
    _searchKeyword = value;

    notifyListeners();
  }

  List<Brand>? get brands => _ref.read(brandServiceP).brands == null
      ? []
      : _ref.read(brandServiceP).brands!.where(
          (element) {
            if (_searchKeyword == null) {
              return true;
            }

            if (_searchKeyword!.trim().isEmpty) {
              return true;
            }
            return element.title.contains(_searchKeyword!) ||
                element.iconName!.contains(_searchKeyword!);
          },
        ).toList();

  fetchBrands() async {
    setBusy(true);
    await _brandService.fetchBrands();
    setBusy(false);
  }

  // bool haveSubscriptions = false;

  // navigateToAddSub() {
  //   $navigationService.navigateTo(NewSubscriptionRoutes.addSubView, id: 2);
  // }

  pop() {
    $uiServices.animateBackToZero();
    $navigationService.back();
  }

  navigateToAddDetails({required Brand brand}) async {
    $navigationService.navigateTo(NewSubscriptionRoutes.addSubDetailsView,
        id: 2, arguments: AddSubDetailsViewArguments(brand: brand));
  }
}
