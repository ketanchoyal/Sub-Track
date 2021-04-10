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
    return Stack(
      children: [
        Center(
          child: Container(
            height: 250,
            width: 500,
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: Colors.white,
                child: Padding(
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            y: 1700,
            rodStackItems: [
              BarChartRodStackItem(0, 200, dark),
              BarChartRodStackItem(200, 1200, normal),
              BarChartRodStackItem(1200, 1700, light),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
          // BarChartRodData(
          //     y: 2400,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 1300, dark),
          //       BarChartRodStackItem(1300, 1400, normal),
          //       BarChartRodStackItem(1400, 2400, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2300.5,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 600.5, dark),
          //       BarChartRodStackItem(600.5, 1800, normal),
          //       BarChartRodStackItem(1800, 2300.5, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2900,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 900, dark),
          //       BarChartRodStackItem(900, 1500, normal),
          //       BarChartRodStackItem(1500, 2900, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 3200,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 200.5, dark),
          //       BarChartRodStackItem(200.5, 1700.5, normal),
          //       BarChartRodStackItem(1700.5, 3200, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 3100,
              rodStackItems: [
                BarChartRodStackItem(0, 1100, dark),
                BarChartRodStackItem(1100, 1800, normal),
                BarChartRodStackItem(1800, 3100, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 3500,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 1400, dark),
          //       BarChartRodStackItem(1400, 2700, normal),
          //       BarChartRodStackItem(2700, 3500, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 3100,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 800, dark),
          //       BarChartRodStackItem(800, 2400, normal),
          //       BarChartRodStackItem(2400, 3100, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1500,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 600.5, dark),
          //       BarChartRodStackItem(600.5, 1200.5, normal),
          //       BarChartRodStackItem(1200.5, 1500, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1700,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 900, dark),
          //       BarChartRodStackItem(900, 1500, normal),
          //       BarChartRodStackItem(1500, 1700, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 3400,
              rodStackItems: [
                BarChartRodStackItem(0, 600, dark),
                BarChartRodStackItem(600, 2300, normal),
                BarChartRodStackItem(2300, 3400, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 3200,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 700, dark),
          //       BarChartRodStackItem(700, 2400, normal),
          //       BarChartRodStackItem(2400, 3200, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1400.5,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 100.5, dark),
          //       BarChartRodStackItem(100.5, 1200, normal),
          //       BarChartRodStackItem(1200, 1400.5, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2000,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 400, dark),
          //       BarChartRodStackItem(400, 1500, normal),
          //       BarChartRodStackItem(1500, 2000, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2400,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 400, dark),
          //       BarChartRodStackItem(400, 1500, normal),
          //       BarChartRodStackItem(1500, 2400, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 1400,
              rodStackItems: [
                BarChartRodStackItem(0, 150.5, dark),
                BarChartRodStackItem(150.5, 1200, normal),
                BarChartRodStackItem(1200, 1400, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2700,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 700, dark),
          //       BarChartRodStackItem(700, 2500, normal),
          //       BarChartRodStackItem(2500, 2700, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2900,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 600, dark),
          //       BarChartRodStackItem(600, 2300, normal),
          //       BarChartRodStackItem(2300, 2900, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1600.5,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 900, dark),
          //       BarChartRodStackItem(900, 1500, normal),
          //       BarChartRodStackItem(1500, 1600.5, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1500,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 700, dark),
          //       BarChartRodStackItem(700, 1200.5, normal),
          //       BarChartRodStackItem(1200.5, 1500, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 1400,
              rodStackItems: [
                BarChartRodStackItem(0, 100.5, dark),
                BarChartRodStackItem(100.5, 1200, normal),
                BarChartRodStackItem(1200, 1400, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2700,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 700, dark),
          //       BarChartRodStackItem(700, 2500, normal),
          //       BarChartRodStackItem(2500, 2700, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 2900,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 600, dark),
          //       BarChartRodStackItem(600, 2300, normal),
          //       BarChartRodStackItem(2300, 2900, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1600.5,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 900, dark),
          //       BarChartRodStackItem(900, 1500, normal),
          //       BarChartRodStackItem(1500, 1600.5, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
          // BarChartRodData(
          //     y: 1500,
          //     rodStackItems: [
          //       BarChartRodStackItem(0, 700, dark),
          //       BarChartRodStackItem(700, 1200.5, normal),
          //       BarChartRodStackItem(1200.5, 1500, light),
          //     ],
          //     borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}
