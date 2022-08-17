import 'package:fl_chart/fl_chart.dart';
import 'bar_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarChartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
      future: getScores(),
      builder: (BuildContext context, AsyncSnapshot<List<BarChartGroupData>> snapshot) {
        if(snapshot.hasData) {
          return BarChart(
          BarChartData(
            maxY: 5,
            barGroups: snapshot.data,
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  reservedSize: 38,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
          ));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ CircularProgressIndicator() ],
            ),
          );
        }
      }
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

    Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Su', style: style);
        break;
      case 1:
        text = const Text('Mo', style: style);
        break;
      case 2:
        text = const Text('Tu', style: style);
        break;
      case 3:
        text = const Text('We', style: style);
        break;
      case 4:
        text = const Text('Th', style: style);
        break;
      case 5:
        text = const Text('Fr', style: style);
        break;
      case 6:
        text = const Text('Sa', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
