import 'package:emojis/emojis.dart';
import 'package:emojis/emoji.dart';

main() {
  print('I ${Emojis.greenHeart} ${Emojis.directHit}'); // I 💚 🎯

  Emoji smile = Emoji.byName('Grinning Face'); // get a emoji by its name
  print('Emoji name      : ${smile.name}');
  // Emoji name is Grinning Face
  print('Emoji character : ${smile.char}');
  // Emoji character is '😀'
  print('Emoji category  : ${smile.emojiGroup}');
  // EmojiGroup.smileysEmotion group of emoji
  print('Emoji sub-group : ${smile.emojiSubgroup}');
  // EmojiSubgroup.faceSmiling sub group of emoji

  // get an emoji by its character 👱‍♀️
  Emoji womanBlond = Emoji.byChar(Emojis.womanBlondHair);
  print(womanBlond);

  // make blondy in black
  Emoji blondyBlackLady = womanBlond.newSkin(fitzpatrick.dark);
  print(blondyBlackLady); // 👱🏿‍♀️

  // disassemble an emoji
  List<String> disassembled = Emoji.disassemble(Emojis.mechanic);
  print(disassembled); // ['🔧', '🧑']

  // assemble some emojis
  String assembled = Emoji.assemble([Emojis.man, Emojis.man, Emojis.girl, Emojis.boy]);
  print(assembled); // 👨‍👨‍👧‍👦️

  String blackThumbsUp = '👍';
  // modify skin tone of emoji
  String witheThumbsUp = Emoji.modify(blackThumbsUp, fitzpatrick.light);
  print(witheThumbsUp); // 👍🏻

  // A Woman Police Officer With Brown Skin
  String femaleCop =  Emojis.womanPoliceOfficerMediumDarkSkinTone;
  // Make that woman to just a Woman Police Officer with no special skin color
  String newFemaleCop = Emoji.stabilize(femaleCop);
  print('$femaleCop => $newFemaleCop'); //👮🏾‍♀️ => 👮‍♀️ 

  // gender-neutral
  String aCop = Emoji.stabilize(femaleCop, skin: false, gender: true);
  print('$femaleCop => $aCop'); //👮🏾‍♀️=> 👮🏾 no gender! still medium dark

  final loveEmojis = Emoji.byKeyword('love'); // returns list of lovely emojis :)
  print(loveEmojis);
  // (🥰, 😍, 😘, 😚, 😙, 🤗, 😻, 😽, 💋, 💌, 💘, 💝, 💖, 💗, 💓, 💞, 💕, ..., 💄, ♾)

  final foodCategory =  Emoji.byGroup(EmojiGroup.foodDrink); // returns emojis in Food and Drink group
  print(foodCategory);
  // (🍇, 🍈, 🍉, 🍊, 🍋, 🍌, 🍍, 🥭, 🍎, 🍏, 🍐, 🍑, 🍒, 🍓, 🥝, 🍅, 🥥, 🥑, ...)

  Iterable<Emoji> moneySubgroupEmojis = Emoji.bySubgroup(EmojiSubgroup.money); // returns emojis in Money subgroup
  print(moneySubgroupEmojis);
  // (💰, 💴, 💵, 💶, 💷, 💸, 💳, 🧾, 💹)

  print(Emoji.emojinize('I :heart: :coffee:'));
  // 'I ❤️ ☕'

  print(Emoji.demojinize('I ❤️ ☕'));
  // 'I :heart: :coffee:'
}
