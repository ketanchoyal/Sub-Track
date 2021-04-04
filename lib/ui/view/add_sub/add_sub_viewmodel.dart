import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class AddSubViewModel extends BaseViewModel with $SharedVariables {
  final _uiServices = locator<UIServices>();
  final _brandService = locator<BrandService>();

  String? _searchKeyword;

  searchKeyword(String? value) {
    _searchKeyword = value;

    notifyListeners();
  }

  List<Brand>? get brands => _brandService.brands == null
      ? []
      : _brandService.brands!.where(
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

  bool haveSubscriptions = false;

  // navigateToAddSub() {
  //   $navigationService.navigateTo(NewSubscriptionRoutes.addSubView, id: 2);
  // }

  pop() {
    $navigationService.back();
  }

  // FIXME Subscription model is necessery
  navigateToAddDetails({required Brand brand}) async {
    $navigationService.navigateTo(NewSubscriptionRoutes.addSubDetailsView,
        id: 2, arguments: AddSubDetailsViewArguments(brand: brand));
  }
}
