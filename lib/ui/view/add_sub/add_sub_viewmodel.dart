import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/ui/services/ui_services.dart';

class AddSubViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _uiServices = locator<UIServices>();
  final _brandService = locator<BrandService>();

  String? _searchKeyword;

  searchKeyword(String? value) {
    _searchKeyword = value;

    notifyListeners();
  }

  List<Brand>? get brands => _brandService.brands?.icons.where(
        (element) {
          if (_searchKeyword == null) {
            return true;
          }

          if (_searchKeyword!.trim().isEmpty) {
            return true;
          }
          return element.title.contains(_searchKeyword!) ||
              element.iconName.contains(_searchKeyword!);
        },
      ).toList();

  fetchBrands() async {
    setBusy(true);
    await _brandService.fetchBrands();
    setBusy(false);
  }

  bool haveSubscriptions = false;

  // navigateToAddSub() {
  //   _navigationService.navigateTo(NewSubscriptionRoutes.addSubView, id: 2);
  // }

  pop() {
    _navigationService.back();
  }

  // FIXME Subscription model is necessery
  navigateToAddDetails({required Brand brand}) async {
    _navigationService.navigateTo(NewSubscriptionRoutes.addSubDetailsView,
        id: 2, arguments: AddSubDetailsViewArguments(brand: brand));
  }
}
