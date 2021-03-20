import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STSegmentController<T> extends StatelessWidget {
  STSegmentController({
    Key? key,
    required this.onValueChanged,
    required this.children,
    this.selectedValue,
  }) : super(key: key);

  final Function(T?) onValueChanged;
  final Map<T, String> children;

  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        width: screenWidth(context),
        child: CupertinoSlidingSegmentedControl<T>(
          // backgroundColor: AppColor.STAccent,
          thumbColor: AppColor.STAccent,
          children: children.map((key, value) => MapEntry(
              key,
              Text(
                value,
                style: kBodyBoldStyle.copyWith(
                  fontSize: selectedValue == key ? 14 : 12,
                  color:
                      selectedValue == key ? AppColor.STLight : AppColor.STDark,
                ),
              ))),
          // {
          //   "Label 1": Text(
          //     "Label 1",
          // style: kBodyBoldStyle.copyWith(
          //   fontSize: 14,
          //   color: AppColor.STLight,
          // ),
          //   ),
          //   "Label 2": Text(
          //     "Label 2",
          //     style: kBodyBoldStyle.copyWith(
          //       fontSize: 12,
          //     ),
          //   ),
          //   "Label 3": Text(
          //     "Label 3",
          //     style: kBodyBoldStyle.copyWith(
          //       fontSize: 12,
          //     ),
          //   ),
          // },
          groupValue: selectedValue,
          onValueChanged: onValueChanged,
        ),
      ),
    );
  }
}
