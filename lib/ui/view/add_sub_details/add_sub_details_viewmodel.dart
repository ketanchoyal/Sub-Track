import 'dart:ui';
import 'package:emojis/emoji.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:uuid/uuid.dart';
import 'add_sub_details_view.formx.dart';

final addSubDetailViewModelCNP = ChangeNotifierProvider.autoDispose(
  (ref) => AddSubDetailsViewModel(ref),
  name: 'AddSubDetailViewModel',
);

class AddSubDetailsViewModel extends FormViewModel with $SharedVariables {
  final Ref _ref;
  @override
  Ref get ref => _ref;
  AddSubDetailsViewModel(this._ref) {
    setBusy(true);
  }
  DialogService get _dialogService => _ref.read(dialogServiceP);
  // get scrollController => _uiServices.scrollController;
  // final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  late final ValueNotifier<Color?> colorChangeNotifier;
  late Brand _brand;
  late Subscription _subscription;
  Subscription get subscription => _subscription;
  bool _isExpanded = false;
  var uuid = Uuid();

  bool get isExpanded => _isExpanded;

  toggleIsExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void setBrand(Brand brand) {
    _brand = brand;
    _setSubscriptionData(
      Subscription(
        brand: _brand,
        cost: 0.0,
        renewsEvery: RenewsEvery.Never,
        subscriptionId: uuid.v1(),
        startedOn: DateTime.now().date,
        sharedWith: 0,
        category: "Default",
        notificationOn: NotifyOn.Never,
      ),
    );
    //Set color Chnage notifier on model ready
    colorChangeNotifier = ValueNotifier(_brand.hex.toColor());
    colorChangeNotifier.addListener(_setColor);
    setBusy(false);
  }

  _setColor() {
    if (colorChangeNotifier.value != null)
      _setSubscriptionData(
        _subscription.copyWith(
          subscriptionId: uuid.v1(),
          brand: _subscription.brand
              .copyWith(hex: colorChangeNotifier.value!.toHex()),
        ),
      );
  }

  _setSubscriptionData(Subscription subscription) {
    _subscription = subscription;
    notifyListeners();
  }

  setDate(DateTime date) {
    _setSubscriptionData(
      _subscription.copyWith(
        subscriptionId: uuid.v1(),
        startedOn: date.date,
      ),
    );
  }

  willPopDialog() {
    _dialogService.showDialog(
      title: "Should Close",
      barrierDismissible: false,
      buttonTitle: "Yes",
      cancelTitle: "No",
      dialogPlatform: DialogPlatform.Cupertino,
    );
  }

  navigateToSelectIcon() async {
    var icon = await $navigationService.navigateTo(
      NewSubscriptionRoutes.selectIconView,
      id: 2,
    );
    print(icon);
    if (icon != null) {
      if (icon is Brand) {
        colorChangeNotifier.value =
            icon.hex.toColor() ?? colorChangeNotifier.value;
        _setSubscriptionData(
          _subscription.copyWith(
            subscriptionId: uuid.v1(),
            brand: _subscription.brand.copyWith(
              iconUrl: icon.iconUrl,
              iconName: null,
              hex: icon.hex,
            ),
          ),
        );
      } else if (Emoji.isEmoji(icon)) {
        _setSubscriptionData(
          _subscription.copyWith(
            subscriptionId: uuid.v1(),
            brand: _subscription.brand.copyWith(
              iconUrl: null,
              iconName: icon,
            ),
          ),
        );
      } else if (icon == "none") {
        _setSubscriptionData(
          _subscription.copyWith(
            subscriptionId: uuid.v1(),
            brand: _subscription.brand.copyWith(
              iconUrl: null,
              iconName: null,
            ),
          ),
        );
      }
    }
  }

  navigateToSelectCategory() async {
    var category = await $navigationService.navigateTo(
      NewSubscriptionRoutes.selectCategoryView,
      id: 2,
      arguments: SelectCategoryViewArguments(selected: _subscription.category),
    );
    _setSubscriptionData(
      _subscription.copyWith(
        subscriptionId: uuid.v1(),
        category: (category as String?) ?? "Default",
      ),
    );
  }

  navigateToOtherSelectView({required OtherDetailSelectType type}) async {
    var result = await $navigationService.navigateTo(
      NewSubscriptionRoutes.otherSelectView,
      id: 2,
      arguments: OtherSelectViewArguments(
        type: type,
        selected: type == OtherDetailSelectType.Notification
            ? _subscription.notificationOn
            : _subscription.renewsEvery,
      ),
    );
    switch (type) {
      case OtherDetailSelectType.Renews_Every:
        _setSubscriptionData(
          _subscription.copyWith(
            subscriptionId: uuid.v1(),
            renewsEvery: result as RenewsEvery?,
          ),
        );
        break;
      case OtherDetailSelectType.Notification:
        _setSubscriptionData(
          _subscription.copyWith(
            subscriptionId: uuid.v1(),
            notificationOn: result as NotifyOn?,
          ),
        );
        break;
    }
    print(result);
  }

  // navigateToRenewSelect() async {
  //   print(renewsEvery);
  // }

  pop() {
    $navigationService.back(id: 2);
  }

  @override
  void setFormStatus() {
    _setSubscriptionData(
      _subscription.copyWith(
        subscriptionId: uuid.v1(),
        brand: _subscription.brand.copyWith(title: nameValue),
        cost: double.parse(hasCost
            ? costValue == ""
                ? "0.0"
                : costValue ?? "0.0"
            : "0.0"),
        description: descriptionValue,
        sharedWith: int.parse(hasSharedWith
            ? sharedWithValue == ""
                ? "0"
                : sharedWithValue ?? "0"
            : "0"),
      ),
    );
  }

  addSubscription() async {
    // print(_subscription);
    await _ref
        .read(subscriptionRepoP)
        .addSubscription(subscription: _subscription);
    $navigationService.back(id: 2);
  }

  // Future? savedData() {
  //   // here we can run custom functionality to save to our api
  // }
}
