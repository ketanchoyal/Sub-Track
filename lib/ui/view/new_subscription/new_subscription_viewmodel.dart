import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';

final newSubscriptionViewModelCNP =
    ChangeNotifierProvider<NewSubscriptionViewModel>(
  (ref) {
    return NewSubscriptionViewModel(ref);
  },
  name: 'NewSubscriptionViewModel',
);

class NewSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  final Ref _ref;

  NewSubscriptionViewModel(this._ref);

  @override
  Ref get ref => _ref;

  bool isDialogPopped = false;

  pop() {
    $uiServices.animateBackToZero();
    $navigationService.back();
  }

  get animator => $uiServices.animatorKey;

  set scrollController(value) => $uiServices.scrollController = value;
}
