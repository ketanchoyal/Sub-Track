part of "shared.dart";

extension FontWeightX on FontWeight {
  ///[FontWeight.w500]
  static const FontWeight medium = FontWeight.w500;

  static const FontWeight bold = FontWeight.bold;

  ///[FontWeight.w400]
  static const FontWeight regular = FontWeight.w400;

  ///[FontWeight.w900]
  static const FontWeight black = FontWeight.w900;
}

extension LoadAssetJson on String {
  Future<String> loadJson() async {
    return rootBundle.loadString(this);
  }
}

extension ColorExtension on String {
  Color? toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension ColorExtensions on Color {
  // ColorExtensions._();

  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100, '');
    final f = 1 - percent / 100;
    return Color.fromARGB(this.alpha, (this.red * f).round(),
        (this.green * f).round(), (this.blue * f).round());
  }

  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100, '');
    final p = percent / 100;
    return Color.fromARGB(
        this.alpha,
        this.red + ((255 - this.red) * p).round(),
        this.green + ((255 - this.green) * p).round(),
        this.blue + ((255 - this.blue) * p).round());
  }
}

extension PaddingX on Widget {
  Padding padding(EdgeInsets padding) => Padding(
        padding: padding,
        child: this,
      );

  Padding paddingA10() => Padding(
        padding: EdgeInsets.all(10),
        child: this,
      );

  Padding paddingA(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Padding paddingH(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Padding paddingV(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );
}
