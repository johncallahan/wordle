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

class GamesScreen extends StatefulHookConsumerWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  String playername = "";

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
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.games.watchAll(params: {'_limit': 5}, syncLocal: true);
    //final _newGameController = useTextEditingController();

    if (state.isLoading) {
      return CircularProgressIndicator();
    }

    Map<String,int> map = {};
    state.model.forEach((x) => map[x.playerid] = (map[x.playerid] ?? 0) + x.guesses);

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
        children: [
          //TextField(
          //  controller: _newGameController,
          //  onSubmitted: (value) async {
          //    Game(word: value).init(ref.read).save();
          //    _newGameController.clear();
          //  },
          //),
          for (final k in map.keys)
            //Dismissible(
            //  key: ValueKey(game),
            //  direction: DismissDirection.endToStart,
            //  onDismissed: (_) => game.delete(),
            //  child:
              ListTile(
                //leading: Checkbox(
                //  value: game.guesses > 0,
                //  onChanged: (value) => game.toggleGuesses().save(),
                //),
                //title: Text('${game.word} [${game.guesses} guesses by ${game.playerid}]'),
                title: Text('${map[k]} ${map[k] == 1 ? "guess" : "guesses"} by ${k} ${k == playername ? "(YOU)" : ""}'),
              ),
            //),
        ],
      ),
    );
  }
}
