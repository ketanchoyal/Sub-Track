import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import "package:collection/collection.dart";

class ExpenseGraph extends StatefulWidget {
  final Map<DateTime, double> data;

  const ExpenseGraph({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => ExpenseGraphState();
}

class ExpenseGraphState extends State<ExpenseGraph> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
                fitInsideHorizontally: false,
                fitInsideVertically: true,
                maxContentWidth: 50,
                tooltipMargin: 0,
                tooltipPadding: EdgeInsets.all(5),
                tooltipBgColor: AppColor.STLight,
                getTooltipItem: (chartData, index, rodData, index2) {
                  return BarTooltipItem(
                    "\$${rodData.y.toStringAsFixed(2)}",
                    kSmallStyle.copyWith(color: AppColor.STDark),
                  );
                }),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (contx, value) => kPreTitleStyle.copyWith(
                color: AppColor.STDark,
              ),
              margin: 10,
              reservedSize: 20,
              getTitles: (double value) {
                return DateFormat('MMM')
                    .format(DateTime(0, value.toInt()))
                    .toUpperCase();
              },
            ),
            topTitles: SideTitles(
              showTitles: false,
            ),
            rightTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles(
              showTitles: false,
            ),
          ),
          gridData: FlGridData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          // groupsSpace: 20,
          barGroups: getData(),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    //Logic to filter data here
    var data = widget.data.entries
        .sorted((a, b) => b.key.compareTo(a.key))
        .groupListsBy((element) {
      return element.key.year;
    });
    Map<int, Map<int, List<MapEntry<int, double>>>> groupedData = {};
    data.forEach((key, value) {
      var newData = value.groupListsBy((element) => element.key.month);
      var moreFiltered = newData.map((key, value) {
        return MapEntry(
            key, value.map((e) => MapEntry(e.key.day, e.value)).toList());
      });
      groupedData.addAll({key: moreFiltered});
    });

    // groupedData.forEach((key, value) {
    //   print("$key : ");
    //   value.forEach((key, value) {
    //     print("$key : ");
    //     value.forEach((element) {
    //       print(element);
    //     });
    //   });
    // });

    List<BarChartGroupData> finalData = groupedData.entries
        .map(
          (ee) {
            return ee.value.entries.map((e) {
              double y = 0.0;
              e.value.forEach((element) {
                y += element.value;
              });
              return BarChartGroupData(
                x: e.key,
                barRods: [
                  BarChartRodData(
                    colors: [
                      AppColor.STAccent,
                    ],
                    y: y,
                    width: 16.5,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(5),
                    ),
                  ),
                ],
              );
            }).toList();
          },
        )
        .toList()
        .expand((element) => element)
        .toList();

    return finalData.take(5).toList().reversed.toList();
  }
}
