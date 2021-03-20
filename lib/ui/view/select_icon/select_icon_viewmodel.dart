import 'package:emojis/emoji.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/ui/shared/shared.dart';

class SelectIconViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  IconType _iconType = IconType.Emoji;
  IconType get iconType => _iconType;
  List<Emoji> _emojiList = Emoji.byGroup(EmojiGroup.smileysEmotion).toList();
  List<Emoji> get emojiList => _emojiList;

  selectIconType(IconType? iconType) {
    if (iconType != null) {
      _iconType = iconType;
      notifyListeners();
    }
  }

  pop() {
    _navigationService.back(id: 2);
  }
}
