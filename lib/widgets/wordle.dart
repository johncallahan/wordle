import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'gaime.dart';
import 'keyboard.dart';

import 'package:provider/provider.dart';

import 'connected.dart';

class WordleWidget extends StatelessWidget {
  const WordleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordle = Provider.of<Wordle>(context);
    print('Did you  win yet? ${wordle.isWon}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        actions: <Widget>[
          Connected(),
        ],
      ),
      body: Column(
        children: const [
          Gaime(),
          Keyboard(),
        ],
      ),
    );
  }
}

class Wordle extends ChangeNotifier {
  int currentGuess = 0;
  List<String> guesses = List.filled(6, '', growable: false);

  // List of letter states for all letters. This gets updated as you guess.
  List<LetterState> letterStates = List.filled(26, LetterState.unknown);

  // List of letter states for each guess.
  List<List<LetterState>> guessLetterStates = [];

  bool isWon = false;
  bool _isActive = true;

  List<String> _word = [];
  List<String> allWords = [];

  Wordle() {
    setup();
  }

  void setup() async {
    isWon = false;
    _isActive = true;
    currentGuess = 0;
    guesses = List.filled(6, '', growable: false);
    letterStates = List.filled(26, LetterState.unknown);
    guessLetterStates = [];

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
