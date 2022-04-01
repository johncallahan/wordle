import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:http/http.dart' as http;

import 'gaime.dart';
import 'keyboard.dart';
import 'gamescreen.dart';

import 'my_shared_preferences.dart';
import 'login.dart';
import 'profile.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';
import '../models/game.dart';

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
    final wordle = ref.watch(wordleChangeNotifier);

    if(wordle.isWon && !wordle.isRecorded) {
      Game(word: wordle.getWord(), guesses: wordle.currentGuess, playerid: playerid).init(ref.read).save();
      wordle.isRecorded = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        actions: <Widget>[
          Connected(),
        ],
      ),
      body: Center(
          child: ref.watch(repositoryInitializerProvider()).when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (_) {
                  final state = ref.games.watchAll();
                  if (state.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return pageIndex == 0 ? Column(
                    children: const [
                      Gaime(),
                      Keyboard(),
                    ],
                  ) : pageIndex == 1 ? GamesScreen()
                  : isLoggedIn ? Profile() : Login();
                }
              ),
        ),
      bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
            ],
          ),
        )
    );
  }
}

final wordleChangeNotifier = ChangeNotifierProvider.autoDispose<Wordle>((ref) {
  return Wordle();
});

class Wordle extends ChangeNotifier {
  int currentGuess = 0;
  List<String> guesses = List.filled(6, '', growable: false);
  //String hostname = "http://localhost:3000";

  // List of letter states for all letters. This gets updated as you guess.
  List<LetterState> letterStates = List.filled(26, LetterState.unknown);

  // List of letter states for each guess.
  List<List<LetterState>> guessLetterStates = [];

  bool isWon = false;
  bool _isActive = true;
  bool isRecorded = false;

  String getWord() {
    return _word.join();
  }

  List<String> _word = [];
  List<String> allWords = [];

  Wordle() {
    setup();
  }

  void setup() async {
    isWon = false;
    _isActive = true;
    isRecorded = false;
    currentGuess = 0;
    guesses = List.filled(6, '', growable: false);
    letterStates = List.filled(26, LetterState.unknown);
    guessLetterStates = [];

    //hostname = await MySharedPreferences.instance.getStringValue("hostname");

    if (allWords.isEmpty) {
      var words = await rootBundle.loadString('assets/wordlists/words.txt');
      allWords = words.split('\n');
    }

    var now = DateTime.now();
    var rand = Random(now.year * 10000 + now.month * 100 + now.day);
    var index = rand.nextInt(allWords.length);

    _word = allWords[index].toUpperCase().split('');
    debugPrint(_word.join());
  }

  void addLetter(String letter) {
    if (!_isActive) {
      return;
    }

    if (letter.length > 1) {
      // shouldn't be possible but here we are
      return;
    }

    if (guesses[currentGuess].length < 5) {
      guesses[currentGuess] = '${guesses[currentGuess]}$letter';
    }

    notifyListeners();
  }

  void backspace() {
    if (!_isActive || guesses[currentGuess].isEmpty) {
      return;
    }

    var curr = guesses[currentGuess];
    guesses[currentGuess] = curr.substring(0, curr.length - 1);

    notifyListeners();
  }

  void submitGuess() {
    if (!_isActive) {
      return;
    }

    var guess = guesses[currentGuess].toUpperCase().split('');

    // guess is too short or too long
    if (guess.length != 5) {
      return;
    }

    List<LetterState> currLetterState = [];
    for (var i = 0; i < _word.length; i++) {
      if (guess[i] == _word[i]) {
        currLetterState.add(LetterState.correctSpot);
      } else if (_word.contains(guess[i])) {
        // TODO: Improve this logic. What if the word has repeated letters?
        currLetterState.add(LetterState.wrongSpot);
      } else if (!_word.contains(guess[i])) {
        currLetterState.add(LetterState.notInWord);
      }

      // update full state list for all guesses
      var letterIndex = guess[i].codeUnitAt(0) - 65;
      if (currLetterState[i] == LetterState.correctSpot) {
        letterStates[letterIndex] = LetterState.correctSpot;
      } else if (currLetterState[i] == LetterState.wrongSpot &&
          letterStates[letterIndex] != LetterState.correctSpot) {
        letterStates[letterIndex] = LetterState.wrongSpot;
      } else if (currLetterState[i] == LetterState.notInWord) {
        letterStates[letterIndex] = LetterState.notInWord;
      }
    }

    guessLetterStates.add(currLetterState);

    if (currLetterState.every((l) => l == LetterState.correctSpot)) {
      // check for win
      isWon = true;
    } else if (currentGuess == 5) {
      // check for lose
      _isActive = false;
    } else {
      // increment guess
      currentGuess++;
    }

    notifyListeners();
  }
}
