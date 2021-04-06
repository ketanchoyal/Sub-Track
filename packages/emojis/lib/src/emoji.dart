import 'emoji_const.dart';
import 'emoji_util.dart';
import 'emojis.dart';

/// All Groups
enum EmojiGroup {
  smileysEmotion,
  activities,
  peopleBody,
  objects,
  travelPlaces,
  component,
  animalsNature,
  foodDrink,
  symbols,
  flags
}

/// All Subgroups
enum EmojiSubgroup {
  faceSmiling,
  faceAffection,
  faceSleepy,
  faceTongue,
  faceNeutralSkeptical,
  faceGlasses,
  faceHat,
  faceConcerned,
  faceNegative,
  faceUnwell,
  faceHand,
  faceCostume,
  event,
  catFace,
  hands,
  handFingersClosed,
  handFingersPartial,
  handSingleFinger,
  handFingersOpen,
  bodyParts,
  handProp,
  clothing,
  emotion,
  personSymbol,
  person,
  personRole,
  personFantasy,
  personGesture,
  personActivity,
  family,
  artsCrafts,
  office,
  hotel,
  skyWeather,
  hairStyle,
  animalMammal,
  animalAmphibian,
  monkeyFace,
  animalBird,
  animalBug,
  animalReptile,
  animalMarine,
  foodMarine,
  plantOther,
  foodVegetable,
  placeBuilding,
  plantFlower,
  placeMap,
  foodFruit,
  foodAsian,
  foodPrepared,
  foodSweet,
  drink,
  dishware,
  sport,
  tool,
  game,
  transportGround,
  personSport,
  transportAir,
  personResting,
  awardMedal,
  placeOther,
  lightVideo,
  music,
  musicalInstrument,
  transportWater,
  otherObject,
  placeGeographic,
  placeReligious,
  time,
  phone,
  computer,
  science,
  household,
  money,
  medical,
  transportSign,
  lock,
  mail,
  bookPaper,
  sound,
  writing,
  religion,
  zodiac,
  alphanum,
  warning,
  avSymbol,
  otherSymbol,
  punctuation,
  geometric,
  keycap,
  arrow,
  math,
  currency,
  gender,
  flag,
  countryFlag,
  subdivisionFlag,
  skinTone,
  regional
}

/// All Skin Tones
enum fitzpatrick { light, mediumLight, medium, mediumDark, dark, None }

/// List of skin tone emojis codepoints.
const skinToneEmojiChars = [
  '\u{1F3FB}',
  '\u{1F3FC}',
  '\u{1F3FD}',
  '\u{1F3FE}',
  '\u{1F3FF}'
];
const _skinToneCharCodes = [127995, 127996, 127997, 127998, 127999];

/// List of chars with zero width
const ZeroWidthCharCodes = [65039, 8205];
const _modifiableCharCodes = [
  127877,
  127938,
  127939,
  127940,
  127943,
  127946,
  127947,
  127948,
  128066,
  128067,
  128070,
  128071,
  128072,
  128073,
  128074,
  128075,
  128076,
  128077,
  128078,
  128079,
  128080,
  128102,
  128103,
  128104,
  128105,
  128107,
  128108,
  128109,
  128110,
  128112,
  128113,
  128114,
  128115,
  128116,
  128117,
  128118,
  128119,
  128120,
  128124,
  128129,
  128130,
  128131,
  128133,
  128134,
  128135,
  128170,
  128372,
  128373,
  128378,
  128400,
  128405,
  128406,
  128581,
  128582,
  128583,
  128587,
  128588,
  128589,
  128590,
  128591,
  128675,
  128692,
  128693,
  128694,
  128704,
  128716,
  129295,
  129304,
  129305,
  129306,
  129307,
  129308,
  129310,
  129311,
  129318,
  129328,
  129329,
  129330,
  129331,
  129332,
  129333,
  129334,
  129335,
  129336,
  129337,
  129341,
  129342,
  129461,
  129462,
  129464,
  129465,
  129467,
  129485,
  129486,
  129487,
  129489,
  129490,
  129491,
  129492,
  129493,
  129494,
  129495,
  129496,
  129497,
  129498,
  129499,
  129500,
  129501,
  9757,
  9977,
  9994,
  9995,
  9996,
  9997
];

class Emoji {
  static const variationSelector16 = 65039;
  static const ZWJ = 8205;

  final String name;
  final String char;
  final String shortName;
  final EmojiGroup emojiGroup;
  final EmojiSubgroup emojiSubgroup;
  final bool modifiable;
  final List<String> keywords;
  List<int>? _runes;

  /// Emoji class.
  /// [name] of emoji. [char] and character of emoji. [shortName] and a digest name of emoji, [emojiGroup] is emoji's group and [emojiSubgroup] is emoji's subgroup. [keywords] list of keywords for emoji. [modifiable] `true` if emoji has skin.
  Emoji({
    required this.name,
    required this.char,
    required this.shortName,
    required this.emojiGroup,
    required this.emojiSubgroup,
    this.keywords = const [],
    this.modifiable = false,
  });

  /// Runes of Emoji Character
  List<int> get charRunes {
    return _runes ??= char.runes.toList();
  }

  /// Returns current Emoji with New requested [skinTone] if modifiable, else Returns current Emoji
  Emoji newSkin(fitzpatrick skinTone) {
    if (modifiable) {
      switch (skinTone) {
        case fitzpatrick.light:
          return Emoji(
            name: this.name + ', tone1',
            char: modify(this.char, skinTone),
            shortName: this.shortName + '_tone1',
            emojiGroup: this.emojiGroup,
            emojiSubgroup: this.emojiSubgroup,
            keywords: this.keywords,
            modifiable: true,
          );
        case fitzpatrick.mediumLight:
          return Emoji(
            name: this.name + ', tone2',
            char: modify(this.char, skinTone),
            shortName: this.shortName + '_tone2',
            emojiGroup: this.emojiGroup,
            emojiSubgroup: this.emojiSubgroup,
            keywords: this.keywords,
            modifiable: true,
          );
        case fitzpatrick.medium:
          return Emoji(
            name: this.name + ', tone3',
            char: modify(this.char, skinTone),
            shortName: this.shortName + '_tone3',
            emojiGroup: this.emojiGroup,
            emojiSubgroup: this.emojiSubgroup,
            keywords: this.keywords,
            modifiable: true,
          );
        case fitzpatrick.mediumDark:
          return Emoji(
            name: this.name + ', tone4',
            char: modify(this.char, skinTone),
            shortName: this.shortName + '_tone4',
            emojiGroup: this.emojiGroup,
            emojiSubgroup: this.emojiSubgroup,
            keywords: this.keywords,
            modifiable: true,
          );
        case fitzpatrick.dark:
          return Emoji(
            name: this.name + ', tone5',
            char: modify(this.char, skinTone),
            shortName: this.shortName + '_tone5',
            emojiGroup: this.emojiGroup,
            emojiSubgroup: this.emojiSubgroup,
            keywords: this.keywords,
            modifiable: true,
          );
        case fitzpatrick.None:
          return Emoji.byChar(stabilize(this.char));
      }
    }
    return this;
  }

  // TODO replace nullEmoji with more appropriate emoji
  factory Emoji.inCaseOfNull() =>
      emojis.where((element) => element.name == "cross mark").first;

  /// Get all Emojis
  static List<Emoji> all() => List.unmodifiable(emojis);

  /// Returns Emoji by [char] and character
  factory Emoji.byChar(String char) {
    return emojis.firstWhere((Emoji emoji) => emoji.char == char,
        orElse: () => Emoji.inCaseOfNull());
  }

  /// Returns if [char] is emoji or not.
  /// use [Emoji.char]
  static bool isEmoji(String char) {
    return emojis.where((Emoji emoji) => emoji.char == char).isNotEmpty;
  }

  /// Returns Emoji by [name]
  factory Emoji.byName(String name) {
    name = name.toLowerCase(); // todo: searchable name
    return emojis.firstWhere((Emoji emoji) => emoji.name == name,
        orElse: () => Emoji.inCaseOfNull());
  }

  /// Returns Emoji by [name] as short name.
  factory Emoji.byShortName(String name) {
    return emojis.firstWhere((Emoji emoji) => emoji.shortName == name,
        orElse: () => Emoji.inCaseOfNull());
  }

  /// Returns list of Emojis in a same [group]
  static Iterable<Emoji> byGroup(EmojiGroup group) {
    return emojis.where((Emoji emoji) => emoji.emojiGroup == group);
  }

  /// Returns list of Emojis in a same [subgroup]
  static Iterable<Emoji> bySubgroup(EmojiSubgroup subgroup) {
    return emojis.where((Emoji emoji) => emoji.emojiSubgroup == subgroup);
  }

  /// Returns List of Emojis with Specific [keyword]
  static Iterable<Emoji> byKeyword(String keyword) {
    keyword = keyword.toLowerCase();
    return emojis.where((Emoji emoji) => emoji.keywords.contains(keyword));
  }

  /// disassemble [emoji] to list of emojis, without skin tones if [noSkin] be `true`.
  static List<String> disassemble(String emoji, {bool noSkin = false}) {
    List<int> emojiRunes = emoji.runes.toList();
    emojiRunes.removeWhere(
      (codeChar) =>
          ZeroWidthCharCodes.contains(codeChar) ||
          (noSkin && _isFitzpatrickCode(codeChar)),
    );
    return emojiRunes.map((char) => String.fromCharCode(char)).toList();
    // return emoji.runes.toList()..removeWhere((codeChar) => ZeroWidthCharCodes.contains(codeChar) || (noSkin && _isFitzpatrickCode(codeChar))).map((char) => String.fromCharCode(char)).toList()
  }

  /// assemble emojis with [emojiChars] codes.
  static String assemble(List<String> emojiChars) {
    List<int> codeCharPoints = [];

    for (var i = 0; i < emojiChars.length; i++) {
      if (i != 0 && !isFitzpatrick(emojiChars[i - 1])) {
        codeCharPoints.add(ZWJ);
      }
      final emojiRunes = emojiChars[i].runes.toList();
      codeCharPoints.addAll(emojiRunes);
    }
    codeCharPoints.add(variationSelector16);
    return String.fromCharCodes(codeCharPoints);
  }

  /// Modify skin tone of [emoji] by requested [skinTone]
  static String modify(String emoji, fitzpatrick skinTone) {
    int skinToneCharCode;
    switch (skinTone) {
      case fitzpatrick.light:
        skinToneCharCode = 127995;
        break;
      case fitzpatrick.mediumLight:
        skinToneCharCode = 127996;
        break;
      case fitzpatrick.medium:
        skinToneCharCode = 127997;
        break;
      case fitzpatrick.mediumDark:
        skinToneCharCode = 127998;
        break;
      case fitzpatrick.dark:
        skinToneCharCode = 127999;
        break;
      case fitzpatrick.None:
        return stabilize(emoji);
    }

    final emojiRunes = emoji.runes.toList();
    List<int> finalCharCodes = [];
    for (final charCode in emojiRunes) {
      if (!_isFitzpatrickCode(charCode)) {
        finalCharCodes.add(charCode);
        if (_isModifiable(charCode)) {
          finalCharCodes.add(skinToneCharCode);
        }
      }
    }
    return String.fromCharCodes(finalCharCodes);
  }

  // todo: support unspecified gender for "... holding hands", "kiss", "couple with heart" and "family".
  /// stabilize [skin] and [gender] of [emoji], if `true`.
  static String stabilize(
    String emoji, {
    bool skin = true,
    bool gender = false,
  }) {
    if (gender) {
      emoji = emoji
          // remove ZWJ man from emoji
          .replaceAll('\u{200D}\u{2642}\u{FE0F}', '')
          // remove ZWJ woman from emoji
          .replaceAll('\u{200D}\u{2640}\u{FE0F}', '')
          // replace man with person
          .replaceAll('\u{1F468}', '\u{1F9D1}')
          // replace woman with person
          .replaceAll('\u{1F469}', '\u{1F9D1}')
          // replace old man with old person
          .replaceAll('\u{1F474}', '\u{1F9D3}')
          // replace old woman with old person
          .replaceAll('\u{1F475}', '\u{1F9D3}');
    }

    final List<int> emojiRunes = emoji.runes.toList();

    if (skin) {
      emojiRunes.removeWhere((codeChar) => _isFitzpatrickCode(codeChar));
    }
    return String.fromCharCodes(emojiRunes);
  }

  /// Emojinize the input text.
  /// For example: 'I :heart: :coffee:' => 'I ❤️ ☕'
  static String emojinize(String text) {
    Iterable<Match> matches = EmojiConst.shortNameRegex.allMatches(text);
    if (matches.isNotEmpty) {
      String result = text;
      matches.toList().forEach((m) {
        final shortName = EmojiUtil.stripColons(m.group(0)!);
        final emoji = Emoji.byShortName(shortName);
        // NOTE removed emoji check if because none of factory method return null anymore
        // if (emoji != Emoji.inCaseOfNull()) {
        result = result.replaceAll(m.group(0)!, emoji.char);
        // }
      });
      return result;
    }
    return text;
  }

  /// This method will demojinize the text containing the Unicode emoji symbols
  /// into emoji name.
  /// For example: 'I ❤️ Flutter' => 'I :heart: Flutter'
  static String demojinize(String text) {
    Iterable<Match> matches = EmojiConst.emojiRegex.allMatches(text);
    if (matches.isNotEmpty) {
      String result = text;
      matches.toList().forEach((m) {
        final emoji = Emoji.byChar(m.group(0)!);
        // NOTE removed emoji check if because none of factory method return null anymore
        // if (emoji != Emoji.inCaseOfNull()) {
        result = result.replaceAll(
          m.group(0)!,
          EmojiUtil.ensureColons(emoji.shortName),
        );

        /// Just a quick hack to clear graphical byte from emoji.
        result = result.replaceAll(
          EmojiConst.charNonSpacingMark,
          EmojiConst.charEmpty,
        );
        // }
      });
      return result;
    }
    return text;
  }

  /// returns `true` if [emojiCode] is code of Emoji with skin!.
  static _isModifiable(int emojiCode) {
    return _modifiableCharCodes.contains(emojiCode);
  }

  /// returns `true` if [emoji] is a Fitzpatrick Emoji.
  static bool isFitzpatrick(String emoji) {
    return skinToneEmojiChars.contains(emoji);
  }

  /// returns `true` if [emojiCode] is code of Fitzpatrick Emoji.
  static bool _isFitzpatrickCode(int emojiCode) {
    return _skinToneCharCodes.contains(emojiCode);
  }

  @override
  toString() => char;
}
