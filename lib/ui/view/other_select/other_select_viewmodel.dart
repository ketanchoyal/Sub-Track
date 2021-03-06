import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/shared.dart';

class OtherSelectViewModel extends BaseViewModel with $SharedVariables {
  late OtherDetailSelectType _type;
  late String _selected;
  late List _options;

  List get options => _options;
  String get selected => _selected;

  pop({dynamic? selected}) =>
      $navigationService.back(id: 2, result: selected ?? _selected);

  setupType(OtherDetailSelectType value, {dynamic selected}) {
    _type = value;
    switch (_type) {
      case OtherDetailSelectType.Renews_Every:
        _selected = (selected as RenewsEvery).value;
        _options = RenewsEvery.values;
        break;
      case OtherDetailSelectType.Notification:
        _selected = (selected as NotifyOn).value;
        _options = NotifyOn.values;
        break;
    }
    notifyListeners();
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
