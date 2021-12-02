import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/shared.dart';

final otherSelectViewModelCNP = ChangeNotifierProvider.autoDispose
    .family<OtherSelectViewModel, OtherDetailSelectType>(
  (ref, type) => OtherSelectViewModel(ref, type),
  name: 'OtherSelectViewModel',
);

class OtherSelectViewModel extends BaseViewModel {
  final Ref _ref;

  OtherSelectViewModel(this._ref, this._type);

  final OtherDetailSelectType _type;
  String? _selected;

  List get options {
    switch (_type) {
      case OtherDetailSelectType.Renews_Every:
        return RenewsEvery.values;

      case OtherDetailSelectType.Notification:
        return NotifyOn.values;
    }
  }

  String? get selected => _selected;

  pop({dynamic selected}) =>
      _ref.read(navigationServiceP).back(id: 2, result: selected);

  setupSelectedValue({required dynamic selected}) {
    setBusy(true);
    switch (_type) {
      case OtherDetailSelectType.Renews_Every:
        _selected = (selected as RenewsEvery).value;
        break;
      case OtherDetailSelectType.Notification:
        _selected = (selected as NotifyOn).value;
        break;
    }
    setBusy(false);
  }

  List getOptions() {
    switch (_type) {
      case OtherDetailSelectType.Renews_Every:
        return RenewsEvery.values.map((e) => [e.value, e]).toList();
      case OtherDetailSelectType.Notification:
        return NotifyOn.values.map((e) => [e.value, e]).toList();
    }
  }
}
