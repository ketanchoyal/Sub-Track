import 'emoji_const.dart';

/// Utilities to handle emoji operations.
class EmojiUtil {
  /// Strip colons for emoji name.
  /// So, ':heart:' will become 'heart'.
  static String stripColons(String name) {
    Iterable<Match> matches = EmojiConst.shortNameRegex.allMatches(name);
    if (matches.isEmpty) {
      return name;
    }
    return name.replaceAll(EmojiConst.charColon, EmojiConst.charEmpty);
  }

  /// Wrap colons on both sides of emoji name.
  /// So, 'heart' will become ':heart:'.
  static String ensureColons(String name) {
    String res = name;
    if (!name.startsWith(EmojiConst.charColon, 0)) {
      res = EmojiConst.charColon + name;
    }

    if (!name.endsWith(EmojiConst.charColon)) {
      res += EmojiConst.charColon;
    }

    return res;
  }

  /// When processing emojis, we don't need to store the graphical byte
  /// which is 0xfe0f, or so-called 'Non-Spacing Mark'.
  static String stripNSM(String name) => name.replaceAll(
        RegExp(EmojiConst.charNonSpacingMark),
        EmojiConst.charEmpty,
      );
}
