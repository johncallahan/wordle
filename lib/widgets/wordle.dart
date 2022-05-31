import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'wordle_logic.dart';

import 'package:http/http.dart' as http;

import 'game_widget.dart';
import 'keyboard_widget.dart';
import 'gamescreen.dart';
import 'guessscreen.dart';
import 'game_widget.dart';

import 'my_shared_preferences.dart';
import 'login.dart';
import 'profile.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';
import '../models/game.dart';
import '../models/guess.dart';

import 'connected.dart';

class WordleWidget extends ConsumerStatefulWidget {
  const WordleWidget({Key? key}) : super(key: key);

  @override
  _WordleWidgetState createState() => _WordleWidgetState();
}

class _WordleWidgetState extends ConsumerState<WordleWidget> {
  int pageIndex = 0;
  bool isLoggedIn = false;
  String playerid = "";
  WordleLogic _wordleLogic = WordleLogic();

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
      .getBooleanValue("loggedin")
      .then((value) => setState(() {
          isLoggedIn = value;
        }));
    MySharedPreferences.instance
      .getStringValue("playerid")
      .then((value) => setState(() {
          playerid = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    //final state = ref.guesses.watchAll(params: {'_limit': 5}, syncLocal: true);
    //final wordle = ref.watch(wordleChangeNotifier);

    //if(wordle.isWon && !wordle.isRecorded) {
    //  Game(word: wordle.getWord(), guesses: wordle.currentGuess, playerid: playerid).init(ref.read).save();
    //  wordle.isRecorded = true;
    //}

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        actions: <Widget>[
        IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.featured_play_list,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.view_list,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.question_mark_outlined,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                      size: 35,
                    ),
              ),
          IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.settings_applications_outlined,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
              ),
          Connected(),
        ],
      ),
      body: Center(
          child: ref.watch(repositoryInitializerProvider()).when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (_) {
                  final state = ref.guesses.watchAll();
                  if (state.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return pageIndex == 0 ? Column(
                    children: [
                      GameWidget(),
                      KeyboardWidget(),
                    ],
                  ) : pageIndex == 1 ? GamesScreen()
                  : pageIndex == 2 ? GuessesScreen()
                  : isLoggedIn ? Profile() : Login();
                }
              ),
        ),
    );
  }
}
