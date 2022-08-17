import 'dart:ui';
import 'dart:convert' as convert;
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../widgets/my_shared_preferences.dart';
import '../environment_config.dart';

BarChartRodData _getScoreBarChartRodData(int index, int currentDayOfWeek, List<dynamic> jsonResponse) {
  try {
    if(jsonResponse[index]['dayofweek'] == currentDayOfWeek) {
      int score = jsonResponse[index]['guesses'];
      switch(score) {
        case 0:
          return BarChartRodData(toY: 0.5, color: Color(0xFF00FF00), width: 15);
        case 1: case 2: case 3: case 4: case 5:
          return BarChartRodData(toY: score.toDouble(), color: Color(0xFF42A5F5), width: 12);
        case -1:
          return BarChartRodData(toY: 0.5, color: Color(0xFFFF0000), width: 15);
        default:
          return BarChartRodData(toY: 0.0, color: Color(0xFF42A5F5), width: 12);
      }
    } else {
      return BarChartRodData(toY: 0.0, color: Color(0xFF42A5F5), width: 12);
    }
  } catch(e) {
    return BarChartRodData(toY: 0.0, color: Color(0xFF42A5F5), width: 12);
  }
}

Future<List<BarChartGroupData>> getScores(String playerid) async {
  var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-Client-ID": playerid,
      };
  var url = Uri.parse(EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT + '/scores');
  try {
    var response = await http.get(url, headers: headers);
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

    List<BarChartGroupData> listArray = [];

    int i = 0;
    for(var currentDayOfWeek=0; currentDayOfWeek < 7; currentDayOfWeek++) {
      listArray.add(
        BarChartGroupData(
          x: currentDayOfWeek,
          barRods: [ _getScoreBarChartRodData(i,currentDayOfWeek,jsonResponse) ])
      );
      i = i < jsonResponse.length - 1 ? i + 1 : i;
    }

    return listArray;
  } catch(_) {
    return empty_barChartGroupData;
  }
}

List<BarChartGroupData> empty_barChartGroupData = [
  BarChartGroupData(x: 0, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 1, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 2, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 3, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 4, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 5, barRods: [
    BarChartRodData(toY: 0),
  ]),
  BarChartGroupData(x: 6, barRods: [
    BarChartRodData(toY: 0),
  ]),
];
