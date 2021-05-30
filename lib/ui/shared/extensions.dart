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

extension ColorX on Color {
  // ColorExtensions._();
  String toHex() {
    return '#${this.value.toRadixString(16)}';
  }

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
      this.blue + ((255 - this.blue) * p).round(),
    );
  }

  Color contrastOf() {
    var brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.light
        ? AppColor.STPureDark
        : AppColor.STPureWhite;
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

extension ForBottomModalSheet on Widget {
  Widget addMaterial() => Material(
        child: this,
      );

  Widget addNavigator() => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context2) => Builder(
            builder: (context) => this,
          ),
        ),
      );
}

// From time package
extension DurationX on Duration {
  static const int daysPerWeek = 7;

  int get inBiWeekly => (inDays / (daysPerWeek * 2)).ceil();

  int get inWeeks => (inDays / daysPerWeek).ceil();
}

// From dart_date package
extension DateTimeX on DateTime {
  DateTime get clone => DateTime.fromMicrosecondsSinceEpoch(
        microsecondsSinceEpoch,
        isUtc: isUtc,
      );
  DateTime get date => DateTime(year, month, day);

  bool get isFuture => this.isAfter(DateTime.now());

  DateTime addMonths(int amount) => clone._setMonth(month + amount);

  DateTime addHalfYear(int amount) => addMonths(amount * 6);

  DateTime addYears(int amount) => clone._setYear(year + amount);

  /// Add a certain amount of quarters to this date
  DateTime addQuarters(int amount) => addMonths(amount * 3);

  bool isAtSameYearAs(DateTime other) => year == other.year;
  bool isAtSameMonthAs(DateTime other) =>
      isAtSameYearAs(other) && month == other.month;

  bool get isToday {
    return _calculateDifference(this) == 0;
  }

  static int _calculateDifference(DateTime date) {
    final now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  DateTime _setMonth(
    int month, [
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]) =>
      DateTime(
        year,
        month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  DateTime _setYear(
    int year, [
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]) =>
      DateTime(
        year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );
}
