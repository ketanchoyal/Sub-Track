import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sub_track/ui/shared/shared.dart';

class History extends StatelessWidget {
  const History({
    Key? key,
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  }) : super(key: key);
  final String title;
  final DateTime date;
  final double amount;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title + " Inc.",
              style: kBodyBoldStyle.copyWith(
                color: color!.contrastOf(),
              ),
            ),
            Text(
              "${DateFormat('dd/MM/yyy').format(date)}",
              style: kSmallStyle.copyWith(
                color: color!.contrastOf().withOpacity(0.7),
              ),
            ),
            verticalSpaceSmall,
          ],
        ),
        Text(
          "\$ $amount",
          style: kHeader3Style.copyWith(
            color: color!.contrastOf(),
          ),
        ),
      ],
    );
  }
}
