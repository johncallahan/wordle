import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/letter_state.dart';

class WordleLogic {
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
    if (!_isActive) {
      return;
    }

    if (letter.length > 1) {
      // shouldn't be possible but here we are
      return;
    }

    if (currentGuess.length < 5) {
      currentGuess = '${currentGuess}$letter';
    }
  }

  void backspace() {
    if (!_isActive || currentGuess.isEmpty) {
      return;
    }

    var curr = currentGuess;
    currentGuess = curr.substring(0, curr.length - 1);
  }
}
