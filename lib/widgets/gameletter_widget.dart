import 'package:flutter/material.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'wordle_logic.dart';

import '../main.data.dart';
import '../models/guess.dart';

class GameLetterWidget extends HookConsumerWidget {
  final int col;
  final int row;
  bool isSubmitted = false;
  String _letter = '';
  LetterState _letterState = LetterState.unknown;

  GameLetterWidget(this.col, this.row, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _logic = ref.watch(logicChangeNotifier);
    final state = ref.guesses.watchAll(params: {'_limit': 5}, syncLocal: true);

    var myList = List.from(state.model);

    myList.sort((a, b) {
      if(a == null) {
        return -1;
      } else if(b == null) {
        return 1;
      } else if(a.id == null) {
        return -1;
      } else if(b.id == null) {
        return 1;
      } else {
        return a.id.compareTo(b.id);
      }
    });
    int i = 0;
    _logic.isWon = false;
    for(var guess in myList) {
      //print(guess.letters);
      _logic.submitGuess(ref,guess.letters,i++,false);
    }

    //print("HELLO WORLD = ${_logic.getWord()}");

    if (myList.length > col && myList[col].letters.length > row) {
      _letter = myList[col].letters.split('')[row];
    } else if(myList.length == col && _logic.currentGuess.length > row) {
      _letter = _logic.currentGuess.split('')[row];
    } else {
      _letter = '';
    }

    if (myList.length > col && myList[col].letters.length > row) {
      _letterState = _logic.processLetter(_letter,row);
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _getBorderColor(),
            width: isSubmitted ? 0 : 2,
          ),
          color: _getBackgroundColor(),
        ),
        width: 50.0,
        height: 50.0,
        child: Center(
          child: Text(
            _letter,
            style: _getTextStyle(),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    var bg = _getBackgroundColor();
    if (bg != Colors.transparent) {
      return bg;
    }

    if (_letter.isNotEmpty) {
      return Colors.grey.shade600;
    }
    return Colors.grey.shade300;
  }

  TextStyle _getTextStyle() {
    if (_letterState == LetterState.notInWord) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    } else if (_letterState == LetterState.wrongSpot) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    } else if (_letterState == LetterState.correctSpot) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    }

    return const TextStyle(
      fontSize: 30.0,
      color: Colors.black,
    );
  }

  Color _getBackgroundColor() {
    if (_letterState == LetterState.notInWord) {
      return Colors.grey.shade600;
    } else if (_letterState == LetterState.wrongSpot) {
      return Colors.yellow.shade600;
    } else if (_letterState == LetterState.correctSpot) {
      return Colors.green.shade600;
    }
    return Colors.transparent;
  }
}
