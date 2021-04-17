import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class BarChartSample4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
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
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => kPreTitleStyle.copyWith(
                color: AppColor.STDarkLight,
              ),
              margin: 10,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 0:
                    return 'JAN';
                  case 1:
                    return 'FEB';
                  case 2:
                    return 'MAR';
                  case 3:
                    return 'APR';
                  case 4:
                    return 'MAY';
                  default:
                    return '';
                }
              },
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
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            y: 1700,
            width: 15,
            rodStackItems: [
              BarChartRodStackItem(0, 200, dark),
              BarChartRodStackItem(200, 1200, normal),
              BarChartRodStackItem(1200, 1700, light),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(2),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 3100,
            width: 15,
            rodStackItems: [
              BarChartRodStackItem(0, 1100, dark),
              BarChartRodStackItem(1100, 1800, normal),
              BarChartRodStackItem(1800, 3100, light),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 3400,
            width: 15,
            rodStackItems: [
              BarChartRodStackItem(0, 600, dark),
              BarChartRodStackItem(600, 2300, normal),
              BarChartRodStackItem(2300, 3400, light),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 1400,
            width: 15,
            rodStackItems: [
              BarChartRodStackItem(0, 150.5, dark),
              BarChartRodStackItem(150.5, 1200, normal),
              BarChartRodStackItem(1200, 1400, light),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: 1400,
            width: 15,
            rodStackItems: [
              BarChartRodStackItem(0, 100.5, dark),
              BarChartRodStackItem(100.5, 1200, normal),
              BarChartRodStackItem(1200, 1400, light),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          ),
        ],
      ),
    ];
  }
}
