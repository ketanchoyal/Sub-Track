enum RenewsEvery {
  Never,
  Daily,
  Weekly,
  Biweekly,
  Monthly,
  Quarterly,
  Half_yearly,
  Yearly,
}

extension RenewsEveryX on RenewsEvery {
  String get name {
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
}

enum NotifyOn {
  Never,
  Same_Day,
  One_Day_Before,
  One_Week_Before,
}

extension NotifyOnX on NotifyOn {
  String get name {
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
