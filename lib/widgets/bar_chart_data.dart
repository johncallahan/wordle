import 'dart:ui';
import 'dart:convert' as convert;
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../widgets/my_shared_preferences.dart';
import '../environment_config.dart';

Future<List<BarChartGroupData>> getScores() async {
  String playerid = await MySharedPreferences.instance.getStringValue("playerid");
  var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-Client-ID": playerid,
      };
  var url = Uri.parse(EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT + '/scores');
  try {
    var response = await http.get(url, headers: headers);
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

    return [
    BarChartGroupData(x: 0, barRods: [
      BarChartRodData(toY: jsonResponse.length > 0 ? jsonResponse[0]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 1, barRods: [
      BarChartRodData(toY: jsonResponse.length > 1 ? jsonResponse[1]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 2, barRods: [
      BarChartRodData(toY: jsonResponse.length > 2 ? jsonResponse[2]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 3, barRods: [
      BarChartRodData(toY: jsonResponse.length > 3 ? jsonResponse[3]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 4, barRods: [
      BarChartRodData(toY: jsonResponse.length > 4 ? jsonResponse[4]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 5, barRods: [
      BarChartRodData(toY: jsonResponse.length > 5 ? jsonResponse[5]["guesses"].toDouble() : 0),
    ]),
     BarChartGroupData(x: 6, barRods: [
      BarChartRodData(toY: jsonResponse.length > 6 ? jsonResponse[6]["guesses"].toDouble() : 0),
    ]),
    ];
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
