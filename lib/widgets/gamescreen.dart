import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:http/http.dart' as http;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';
import '../models/game.dart';

class GamesScreen extends HookConsumerWidget {
  Future<bool> checkConnection() async {
    var url = Uri.parse('http://127.0.0.1:3000/games');
    try {
      var response = await http.get(url);
      print("service UP");
      return true;
    } catch(_) {
      print("service DOWN");
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.games.watchAll(params: {'_limit': 5}, syncLocal: true);
    final _newGameController = useTextEditingController();

    if (state.isLoading) {
      return CircularProgressIndicator();
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
        children: [
          //TextField(
          //  controller: _newGameController,
          //  onSubmitted: (value) async {
          //    Game(word: value).init(ref.read).save();
          //    _newGameController.clear();
          //  },
          //),
          for (final game in state.model)
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
                title: Text('${game.word} [${game.guesses} guesses by ${game.playerid}]'),
              ),
            //),
        ],
      ),
    );
  }
}
