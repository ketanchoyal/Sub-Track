import 'package:emojis/emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/brand_service.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/shared.dart';

final selectIconViewModelCNP = ChangeNotifierProvider.autoDispose(
  (ref) {
    return SelectIconViewModel(ref);
  },
  name: 'SelectIconViewModel',
);

// NOTE Merge all emoji and use that when emoji is searched instead of individual search of every group
class SelectIconViewModel extends BaseViewModel with $SharedVariables {
  // use [brandRepoP] instread of brandService
  BrandService get _brandService => _ref.read(brandServiceP);

  final ProviderRefBase _ref;

  SelectIconViewModel(this._ref);

  @override
  ProviderRefBase get ref => _ref;

  IconType _iconType = IconType.Services;
  IconType get iconType => _iconType;

  List<Brand>? get brands => _brandService.brands!.where(
        (element) {
          if (_searchKeyword == null) {
            return true;
          }

          if (_searchKeyword!.trim().isEmpty) {
            return true;
          }
          return element.title.contains(_searchKeyword!) ||
              element.iconName!.contains(_searchKeyword!);
        },
      ).toList();

  fetchBrands() async {
    setBusy(true);
    await _brandService.fetchBrands();
    setBusy(false);
  }

  selectEmoji(Emoji emoji) {
    pop(result: emoji.char);
  }

  selectService(Brand brand) {
    pop(result: brand);
  }

  String? _searchKeyword;
  bool isSearching = false;

  void selectIconType(IconType? iconType) {
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

  selectNone() {
    pop(result: "none");
  }

  pop({result}) {
    $navigationService.back(id: 2, result: result);
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

  // TODO Refractor emojis (hint: make a map [<EmojiGroup,bool>] and convert [EmojiGroup] widget to hook)

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
