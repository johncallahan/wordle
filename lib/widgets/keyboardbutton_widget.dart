import 'package:flutter/material.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

import 'wordle_logic.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KeyboardButtonWidget extends ConsumerStatefulWidget {
  String _value;
  WordleLogic _logic;
  LetterState _letterState = LetterState.unknown;

  KeyboardButtonWidget(this._logic, this._value, {Key? key}) : super(key: key);

  @override
  _KeyboardButtonWidgetState createState() => _KeyboardButtonWidgetState();
}

class _KeyboardButtonWidgetState extends ConsumerState<KeyboardButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final myLogic = ref.watch(logicChangeNotifier);
    var letter = widget._value.codeUnitAt(0) - 65;
    var letterState = widget._logic.letterStates[letter];

    return Padding(
      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
      child: SizedBox(
        width: 30.0,
        child: TextButton(
          child: Text(
            widget._value,
            style: _getTextStyle(letterState),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(_getBackgroundColor(letterState)),
            textStyle: MaterialStateProperty.all(_getTextStyle(letterState)),
          ),
          onPressed: () {
            //setState(() {
              widget._logic.addLetter(widget._value);
            //});
          },
        ),
      ),
    );
  }

  Color _getBackgroundColor(LetterState letterState) {
    if (letterState == LetterState.wrongSpot) {
      return Colors.yellow.shade600;
    } else if (letterState == LetterState.correctSpot) {
      return Colors.green.shade600;
    } else if (letterState == LetterState.notInWord) {
      return Colors.grey.shade600;
    }
    return Colors.grey.shade300;
  }

  TextStyle _getTextStyle(LetterState letterState) {
    if (letterState == LetterState.unknown) {
      return const TextStyle(
        color: Colors.black,
      );
    }
    return const TextStyle(
      color: Colors.white,
    );
  }
}
