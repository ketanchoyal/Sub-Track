import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:emojis/src/emoji_const.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Emojis.directHit is 🎯', () {
    var result = "🎯";
    expect(Emojis.directHit, equals(result));
  });

  test('Regex pattern matches all emojis', () {
    for (var emoji in Emoji.all()) {
      if (emoji.name == 'transgender symbol') continue;
      expect(
        EmojiConst.emojiRegex.allMatches(emoji.char).length,
        1,
        reason: 'Bad reg match for ${emoji.name}',
      );
    }
  });

  // todo: test assemble for all assemblable emojis

  test('Search for emoji with invalid name', () {
    final emoji = Emoji.byName('bla');
    expect(emoji, isNull);
  });

  group('Emoji.emojinize', () {
    test('returns emojinized string', () {
      final demojinizeString = 'I :heart: :coffee:';
      expect(Emoji.emojinize(demojinizeString), 'I ❤️ ☕');
    });
  });

  group('Emoji.demojinize', () {
    test('returns demojinize string', () {
      final emojinizeString = 'I ❤️ ☕';
      expect(Emoji.demojinize(emojinizeString), 'I :heart: :coffee:');
    });
  });
}
