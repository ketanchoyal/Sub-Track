// ignore: import_of_legacy_library_into_null_safe

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';

class DemoViewModel extends BaseViewModel {
  NavigationService get navigationService => _ref.read(navigationServiceP);

  DemoViewModel(this._ref);

  final ProviderRef _ref;

  navigate() => navigationService.navigateTo(Routes.startUpView);
}
