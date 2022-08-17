import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/letter_state.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';
import '../models/game.dart';
import '../models/guess.dart';

final logicChangeNotifier = ChangeNotifierProvider.autoDispose<WordleLogic>((ref) {
  return WordleLogic();
});

class WordleLogic extends ChangeNotifier {
  String currentGuess = "";
  // List of letter states for all letters. This gets updated as you guess.
  List<LetterState> letterStates = List.filled(26, LetterState.unknown);
  // List of letter states for each guess.
  List<List<LetterState>> guessLetterStates = [];
  bool isWon = false;
  bool _isActive = true;
  bool isRecorded = false;
  List<String> _word = [];
  List<String> allWords = [];

  Future<void> loadWords() async {
    var words = await rootBundle.loadString('assets/wordlists/words.txt');
    allWords = words.split('\n');
    var now = DateTime.now();
    var rand = Random(now.year * 10000 + now.month * 100 + now.day);
    var index = rand.nextInt(allWords.length);
    _word = allWords[index].toUpperCase().split('');
    print(_word);
  }

  WordleLogic() {
    isWon = false;
    _isActive = true;
    isRecorded = false;
    currentGuess = "";
    letterStates = List.filled(26, LetterState.unknown);
    guessLetterStates = [];

    if (allWords.isEmpty) {
      loadWords();
    }
  }

  String getWord() {
    return _word.join();
  }

  void addLetter(String letter) {
    if (isWon || !_isActive) {
      return;
    }

    if (letter.length > 1) {
      // shouldn't be possible but here we are
      return;
    }

    if (currentGuess.length < 5) {
      currentGuess = '${currentGuess}$letter';
    }

    print(currentGuess);

    notifyListeners();
  }

  void backspace() {
    if (!_isActive || currentGuess.isEmpty) {
      return;
    }

    var curr = currentGuess;
    currentGuess = curr.substring(0, curr.length - 1);

    notifyListeners();
  }

  LetterState processLetter(String letter, int position) {
    if(_word.length == 0) {
      return LetterState.unknown;
    } else if (letter == _word[position]) {
      return LetterState.correctSpot;
    } else if (_word.contains(letter)) {
      // TODO: Inefficient if the word has letters that repeat?
      return LetterState.wrongSpot;
    } else if (!_word.contains(letter)) {
      return LetterState.notInWord;
    } else {
      return LetterState.unknown;
    }
  }

  List<LetterState> processGuess(List<String> guess) {
    List<LetterState> currLetterState = [];
    for (var i = 0; i < _word.length; i++) {
      currLetterState.add(processLetter(guess[i], i));

      // update full state list for all guesses
      var letterIndex = guess[i].codeUnitAt(0) - 65;
      if (currLetterState[i] == LetterState.correctSpot) {
        letterStates[letterIndex] = LetterState.correctSpot;
      } else if (currLetterState[i] == LetterState.wrongSpot && letterStates[letterIndex] != LetterState.correctSpot) {
        letterStates[letterIndex] = LetterState.wrongSpot;
      } else if (currLetterState[i] == LetterState.notInWord) {
        letterStates[letterIndex] = LetterState.notInWord;
      }
    }

    guessLetterStates.add(currLetterState);

    return currLetterState;
  }

  void submitGuess(WidgetRef ref, String guessString, int numOfGuesses, bool recordIt, String playerid) {
    if (!_isActive || (isWon && !recordIt)) {
      return;
    }

    var guess = guessString.toUpperCase().split('');

    // guess is too short or too long
    if (guess.length != 5) {
      return;
    }

    var currLetterState = processGuess(guess);

    //print(numOfGuesses);

    if (recordIt && currLetterState.every((l) => l == LetterState.correctSpot)) {
      // check for win
      isWon = true;
      Guess(letters: currentGuess, playerid: playerid).init(ref.read).save();
      Game(word: currentGuess, guesses: numOfGuesses, playerid: playerid).init(ref.read).save();
    } else if (currLetterState.every((l) => l == LetterState.correctSpot)) {
      isWon = true;
    } else if (numOfGuesses >= 5) {
      // sorry, you lost
      _isActive = false;
      if(recordIt) {
        Guess(letters: currentGuess, playerid: playerid).init(ref.read).save();
        Game(word: currentGuess, guesses: 99, playerid: playerid).init(ref.read).save();
      }
    } else if (recordIt) {
      Guess(letters: currentGuess, playerid: playerid).init(ref.read).save();
    }

    if(recordIt) notifyListeners();
  }
}
