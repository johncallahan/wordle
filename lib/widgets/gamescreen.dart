import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:http/http.dart' as http;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'my_shared_preferences.dart';

import '../main.data.dart';
import '../models/game.dart';
import '../environment_config.dart';

import 'bar_chart.dart';
import 'chart_container.dart';

class GamesScreen extends StatefulHookConsumerWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  String playername = "";
  String playerid = "";

  Future<bool> checkConnection() async {
    var url = Uri.parse(EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT + '/games');
    try {
      var response = await http.get(url);
      //print("service UP");
      return true;
    } catch(_) {
      //print("service DOWN");
      return false;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final state = ref.games.watchAll(params: {'_limit': 5}, syncLocal: true);
    //final _newGameController = useTextEditingController();

    if (state.isLoading) {
      return CircularProgressIndicator();
    }

    Map<String,int> map = {};
    state.model.forEach((x) => map[x.playername] = (map[x.playername] ?? 0) + x.guesses);

    Map<String,String?> pidmap = {};
    state.model.forEach((x) => pidmap[x.playername] = x.playerid);

    List<Widget> children = [];

    if(map.keys.length > 0) {
      for (final k in map.keys) {
        children.add(
          ListTile(
            title: Text('${map[k]} ${map[k] == 1 ? "guess" : "guesses"} by ${k} ${k == playername ? "(YOU)" : ""}'),
          )
        );
        String friendPlayerId = pidmap[k]!;
          children.add(
            ChartContainer(
              title: 'This week',
              color: Color(0xffD9E3F0),
              chart: BarChartContent(friendPlayerId)
            )
          );
      }
    } else {
      children.add(
        ListTile(title: Text('You have not finished today'))
      );
      children.add(
        ChartContainer(
          title: 'This week',
          color: Color(0xffD9E3F0),
          chart: BarChartContent(this.playerid)
        )
      );
    }



    return RefreshIndicator(
      onRefresh: () async {
          if(await checkConnection()) {
            ref.games.findAll(params: {'_limit': 5}, syncLocal: true);
            final provider = repositoryProviders['games'];
            if (provider != null) {
              final operations = ref.read(provider).offlineOperations;
              print('== Retrying (${operations.length} operations) ==');
              await operations.retry();
            }
          }
      },
      child: ListView(
        children: children
      ),
    );
  }
}
