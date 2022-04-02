part of "enums.dart";

// SECTION ENUM
extension RenewsEveryX on RenewsEvery {
  String get value {
    switch (this) {
      case RenewsEvery.Never:
        return "Never";
      case RenewsEvery.Daily:
        return "Daily";
      case RenewsEvery.Weekly:
        return "Weekly";
      case RenewsEvery.Biweekly:
        return "Bi-Weekly";
      case RenewsEvery.Monthly:
        return "Monthly";
      case RenewsEvery.Quarterly:
        return "Quarterly";
      case RenewsEvery.Half_yearly:
        return "Half-Yearly";
      case RenewsEvery.Yearly:
        return "Yearly";
    }
  }

  String get initial {
    switch (this) {
      case RenewsEvery.Never:
        return "";
      case RenewsEvery.Daily:
        return "day";
      case RenewsEvery.Weekly:
        return "w";
      case RenewsEvery.Biweekly:
        return "bw";
      case RenewsEvery.Monthly:
        return "m";
      case RenewsEvery.Quarterly:
        return "q";
      case RenewsEvery.Half_yearly:
        return "halfyear";
      case RenewsEvery.Yearly:
        return "yr";
    }
  }
}

extension NotifyOnX on NotifyOn {
  String get value {
    switch (this) {
      case NotifyOn.Never:
        return "Never";
      case NotifyOn.Same_Day:
        return "Same Day";
      case NotifyOn.One_Day_Before:
        return "One Day Before";
      case NotifyOn.One_Week_Before:
        return "One Week Before";
    }
  }
}

extension IconTypeX on SubIconType {
  String get value {
    switch (this) {
      case SubIconType.SVG:
        return "svg";
      case SubIconType.EMOJI:
        return "emoji";
      case SubIconType.NONE:
        return "none";
    }
  }
}

// !SECTION

// SECTION String

extension EnumString on String? {
  /// RenewsEvery enum from String
  RenewsEvery get enumRE {
    switch (this) {
      case "Never":
        return RenewsEvery.Never;
      case "Daily":
        return RenewsEvery.Daily;
      case "Weekly":
        return RenewsEvery.Weekly;
      case "Bi-Weekly":
        return RenewsEvery.Biweekly;
      case "Monthly":
        return RenewsEvery.Monthly;
      case "Quarterly":
        return RenewsEvery.Quarterly;
      case "Half-Yearly":
        return RenewsEvery.Half_yearly;
      case "Yearly":
        return RenewsEvery.Yearly;
      default:
        return RenewsEvery.Never;
    }
  }

  /// NotifyOn enum from String
  NotifyOn get enumNO {
    switch (this) {
      case "Never":
        return NotifyOn.Never;
      case "Same Day":
        return NotifyOn.Same_Day;
      case "One Day Before":
        return NotifyOn.One_Day_Before;
      case "One Week Before":
        return NotifyOn.One_Week_Before;
      default:
        return NotifyOn.Never;
    }
  }

  /// IconType enum from String
  SubIconType get enumIT {
    switch (this) {
      case "svg":
        return SubIconType.SVG;
      case "emoji":
        return SubIconType.EMOJI;
      case "none":
        return SubIconType.NONE;
      default:
        return SubIconType.NONE;
    }
  }
}

// !SECTION