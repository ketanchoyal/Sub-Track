import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/url_launch_service.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class ActiveSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  bool isDialogPopped = false;
  double scale = 1.0;
  SubscriptionRepo get _subscriptionRepo => locator<SubscriptionRepo>();
  UrlLaunchService get _urlLaunchService => locator<UrlLaunchService>();
  late Subscription _selectedSub;
  Subscription get selectedSub => _selectedSub;
  Map<String, int?> _remaningDays = {};

  ActiveSubscriptionViewModel() {
    _selectedSub = subscriptions.first;
  }

  selectSub(Subscription sub) {
    _selectedSub = sub;
    notifyListeners();
  }

  bool isCurrentSelected(Subscription sub) {
    return sub.subscriptionId == _selectedSub.subscriptionId;
  }

  List<Subscription> get subscriptions =>
      _subscriptionRepo.getSubscriptionsOnce();

  pop() {
    $navigationService.back();
  }

  int? get remainingDays {
    if (!_remaningDays.containsKey(_selectedSub.subscriptionId)) {
      $calculationService.calculateRemainingDays(_selectedSub).then((value) {
        _remaningDays.addAll({_selectedSub.subscriptionId: value});
        notifyListeners();
      });
      return null;
    }
    return _remaningDays[_selectedSub.subscriptionId];
  }

  openLink() {
    if (selectedSub.brand.source != null)
      _urlLaunchService.launchUrl(selectedSub.brand.source!);
  }
}
