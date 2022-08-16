import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';

final Future<List<BarChartGroupData>> barChartGroupData = Future<List<BarChartGroupData>>.delayed(
    const Duration(seconds: 2),
    () => old_barChartGroupData,
  );

List<BarChartGroupData> old_barChartGroupData = [
  BarChartGroupData(x: 0, barRods: [
    BarChartRodData(toY: 4),
  ]),
   BarChartGroupData(x: 1, barRods: [
    BarChartRodData(toY: 3),
  ]),
   BarChartGroupData(x: 2, barRods: [
    BarChartRodData(toY: 5),
  ]),
   BarChartGroupData(x: 3, barRods: [
    BarChartRodData(toY: 0),
  ]),
   BarChartGroupData(x: 4, barRods: [
    BarChartRodData(toY: 3),
  ]),
   BarChartGroupData(x: 5, barRods: [
    BarChartRodData(toY: 3),
  ]),
   BarChartGroupData(x: 6, barRods: [
    BarChartRodData(toY: 3),
  ]),
];
