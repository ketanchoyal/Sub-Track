import 'dart:ui';

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
