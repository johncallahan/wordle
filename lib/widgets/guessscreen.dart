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
import '../models/guess.dart';
import '../environment_config.dart';

class GuessesScreen extends StatefulHookConsumerWidget {
  const GuessesScreen({Key? key}) : super(key: key);

  @override
  _GuessesScreenState createState() => _GuessesScreenState();
}

class _GuessesScreenState extends ConsumerState<GuessesScreen> {
  String playername = "";

  Future<bool> checkConnection() async {
    var url = Uri.parse(EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT + '/guesses');
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
    final state = ref.guesses.watchAll(params: {'_limit': 5}, syncLocal: true);
    //final _newGuessController = useTextEditingController();

    if (state.isLoading) {
      return CircularProgressIndicator();
    }

    Map<String,String> map = {};
    state.model.forEach((x) => map[x.letters] = x.playerid);

    return RefreshIndicator(
      onRefresh: () async {
          if(await checkConnection()) {
            ref.guesses.findAll(params: {'_limit': 5}, syncLocal: true);
            final provider = repositoryProviders['guesses'];
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
          //  controller: _newGuessController,
          //  onSubmitted: (value) async {
          //    Guess(letters: value).init(ref.read).save();
          //    _newGuessController.clear();
          //  },
          //),
          for (final k in map.keys)
            //Dismissible(
            //  key: ValueKey(guess),
            //  direction: DismissDirection.endToStart,
            //  onDismissed: (_) => guess.delete(),
            //  child:
              ListTile(
                //leading: Checkbox(
                //  value: guess.guesses > 0,
                //  onChanged: (value) => guess.toggleGuesses().save(),
                //),
                //title: Text('${guess.letters} [${guess.guesses} guesses by ${guess.playerid}]'),
                title: Text('${k} by ${map[k]}'),
              ),
            //),
        ],
      ),
    );
  }
}
