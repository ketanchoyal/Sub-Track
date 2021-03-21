import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/shared/shared.dart';

class EmojiGroup extends StatelessWidget {
  const EmojiGroup({
    Key? key,
    required this.emojis,
    required this.showMore,
    required this.onPressed,
    required this.categoryName,
    required this.onShowMorePressed,
  }) : super(key: key);

  // Approx box size
  final double iconBoxSize = 60;
  final List emojis;
  final bool showMore;
  final Function(dynamic) onPressed;
  final Function() onShowMorePressed;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: kBodyBoldStyle,
            ),
            CupertinoButton(
              child: Icon(
                showMore
                    ? CupertinoIcons.chevron_up
                    : CupertinoIcons.chevron_down,
              ),
              onPressed: onShowMorePressed,
            )
            // STButton(
            //   buttonType: ButtonType.PRIMARY,
            //   icon: Icon(
            //     CupertinoIcons.chevron_down,
            //   ),
            //   // buttonText: showMore ? "Show less" : "Show more",
            //   onPressed: onShowMorePressed,
            // ),
          ],
        ).paddingH(8).paddingV(5),
        GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth(context) ~/ iconBoxSize,
          ),
          itemCount: showMore
              ? emojis.length
              : emojis.length > 12
                  ? 12
                  : emojis.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onPressed(emojis[index]);
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: kRoundedCardBorder(side: kDefaultCardBorderSide),
                child: Center(
                  child: Text(
                    emojis[index].toString(),
                    style: kHeader2Style,
                  ),
                ),
              ),
            );
          },
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child:
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
