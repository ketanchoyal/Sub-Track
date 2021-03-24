import 'package:emojis/emoji.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/ui/shared/shared.dart';

// NOTE Merge all emoji and use that when emoji is searched instead of individual search of every group
class SelectIconViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _brandService = locator<BrandService>();

  IconType _iconType = IconType.Services;
  IconType get iconType => _iconType;

  List<Brand>? get brands => _brandService.brands?.brands.where(
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

  String? _searchKeyword;
  bool isSearching = false;

  selectIconType(IconType? iconType) {
    if (iconType != null) {
      _iconType = iconType;
      notifyListeners();
    }
  }

  searchKeyword(String? value) {
    _searchKeyword = value;
    if (_searchKeyword == null) {
      isSearching = false;
    } else if (_searchKeyword!.trim().isEmpty) {
      isSearching = false;
    } else {
      isSearching = true;
    }

    notifyListeners();
  }

  pop() {
    _navigationService.back(id: 2);
  }

  List<Emoji> get filteredEmojiList => Emoji.all().where(
        (element) {
          if (_searchKeyword == null) {
            return true;
          }

          if (_searchKeyword!.trim().isEmpty) {
            return true;
          }
          return element.keywords.contains(_searchKeyword);
        },
      ).toList();

  // TODO Refractor emojis (hint: make a map and convert [EmojiGroup] widget to hook)

  // SIMILEY
  bool showMoreSmiley = false;
  toogleShowMoreSmiley() {
    showMoreSmiley = !showMoreSmiley;
    notifyListeners();
  }

  List<Emoji> get simileyEmojiList =>
      Emoji.byGroup(EmojiGroup.smileysEmotion).toList();

  // PEOPLE
  bool showMorePeople = false;
  toogleShowMorePeople() {
    showMorePeople = !showMorePeople;
    notifyListeners();
  }

  List<Emoji> get peopleEmojiList =>
      Emoji.byGroup(EmojiGroup.peopleBody).toList();

  // SYMBOL
  bool showMoreSymbols = false;
  toogleShowMoreSymbols() {
    showMoreSymbols = !showMoreSymbols;
    notifyListeners();
  }

  List<Emoji> get symbolEmojiList => Emoji.byGroup(EmojiGroup.symbols).toList();

  // ANIMALS
  bool showMoreAnimals = false;
  toogleShowMoreAnimals() {
    showMoreAnimals = !showMoreAnimals;
    notifyListeners();
  }

  List<Emoji> get animalEmojiList =>
      Emoji.byGroup(EmojiGroup.animalsNature).toList();

  // FLAGS
  bool showMoreFlags = false;
  toogleShowMoreFlags() {
    showMoreFlags = !showMoreFlags;
    notifyListeners();
  }

  List<Emoji> get flagEmojiList => Emoji.byGroup(EmojiGroup.flags).toList();

  // OBJECTS
  bool showMoreObject = false;
  toogleShowMoreObjects() {
    showMoreObject = !showMoreObject;
    notifyListeners();
  }

  List<Emoji> get objectEmojiList => Emoji.byGroup(EmojiGroup.objects).toList();
}
