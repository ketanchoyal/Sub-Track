import 'dart:io';
import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/core/services/file_service.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class HomeViewModel extends BaseViewModel with $SharedVariables {
  bool haveSubscriptions = false;
  SubscriptionRepo _subscriptionRepo = locator<SubscriptionRepo>();
  SubscriptionLocalDataSource _subscriptionLocalDataSource =
      locator<SubscriptionLocalDataSource>();
  CalculationService _calculationService = locator<CalculationService>();
  FileService _fileService = locator<FileService>();

  List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;
  Map<String, int?> _remaningDays = {};

  int? remainingDays({required Subscription subscription}) {
    if (!_remaningDays.containsKey(subscription.subscriptionId)) {
      _calculationService.calculateRemainingDays(subscription).then((value) {
        _remaningDays.addAll({subscription.subscriptionId: value});
        notifyListeners();
      });
      return null;
    }
    return _remaningDays[subscription.subscriptionId];
  }

  double _totalExpense = 0.0;
  String get totalExpense => _totalExpense.toStringAsFixed(2);

  navigateToAddSub() {
    $navigationService.navigateTo(Routes.newSubscription);
  }

  clean() {
    _subscriptionLocalDataSource.cleanEverything();
  }

  startupTasks() {
    _fetchSubs();
    _getTotalExpense();
    notifyListeners();
  }

  _fetchSubs() async {
    if (_subscriptions.isEmpty)
      (await _subscriptionRepo.fetchSubscriptions()).listen((event) {
        _subscriptions = event;
        notifyListeners();
      });
  }

  _getTotalExpense() async {
    _totalExpense = await _calculationService.getTotalExpense();
    notifyListeners();
  }

  File? _image;
  File? get image => _image;

  saveImage(image) {
    _fileService.saveHomeScreen(image);
    notifyListeners();
  }
}
