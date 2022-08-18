import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import '../environment_config.dart';

import 'my_shared_preferences.dart';

import 'bar_chart.dart';
import 'chart_container.dart';

class Player {
  Player(this.name,this.playerid);

  String name;
  String playerid;
}

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  String playername = "";
  String playerid = "";

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
      .getStringValue("playername")
      .then((value) => setState(() {
          playername = value;
        }));
    MySharedPreferences.instance
      .getStringValue("playerid")
      .then((value) => setState(() {
          playerid = value;
        }));
  }

  Future<List<Player>> getPlayers(String playerid) async {
    var headers = {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-Client-ID": playerid,
        };
    var url = Uri.parse(EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT + '/players');
    List<Player> playerList = [];

    try {
      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

      for(var i = 0;  i < jsonResponse.length; i++) {
        playerList.add(Player(jsonResponse[i]['name'],jsonResponse[i]['playerid']));
      }

      return playerList;
    } catch(_) {
      return playerList;
    }
  }

  List<Widget> enumeratePlayers(List<Player>? playerList) {
    List<Widget> widgets = [];
    if(playerList != null) {
      playerList.forEach((value){
        widgets.add(
          ListTile(title: new Center(child: new Text('------------------------------')))
        );
        widgets.add(
          ChartContainer(
            title: 'This week (${value.playerid == this.playerid ? this.playername + " - YOU" : value.name})',
            color: Color(0xffD9E3F0),
            chart: BarChartContent(value.playerid)
          ));
      });
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: getPlayers(this.playerid),
      builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
        if(snapshot.hasData) {
          return ListView(
            padding: EdgeInsets.only(bottom: 200),
            children: enumeratePlayers(snapshot.data)
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ CircularProgressIndicator() ],
            ),
          );
        }
      });
  }
}
