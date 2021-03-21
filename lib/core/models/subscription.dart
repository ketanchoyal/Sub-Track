import 'package:sub_track/core/models/brands.dart';

class Subsription {
  final Brand brand;
  final double cost;
  final String? description;

  final String repeatEvery;
  final String? category;
  final int? sharedWith;
  final DateTime startedOn;
  final String notificationOn;
  int? remaningDays;
  // TODO Research how to store amount paid until now with the date(hint: use map)

  Subsription({
    required this.brand,
    required this.cost,
    this.description,
    required this.repeatEvery,
    this.category,
    this.sharedWith,
    required this.startedOn,
    required this.notificationOn,
  });

  Subsription copyWith({
    Brand? brand,
    double? cost,
    String? description,
    String? repeatEvery,
    String? category,
    int? sharedWith,
    DateTime? startedOn,
    String? notificationOn,
  }) =>
      Subsription(
        brand: brand ?? this.brand,
        cost: cost ?? this.cost,
        description: description ?? this.description,
        repeatEvery: repeatEvery ?? this.repeatEvery,
        category: category ?? this.category,
        sharedWith: sharedWith ?? this.sharedWith,
        startedOn: startedOn ?? this.startedOn,
        notificationOn: notificationOn ?? this.notificationOn,
      );
}
