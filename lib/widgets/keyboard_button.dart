import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

class KeyboardButton extends StatefulWidget {
  String _value;
  LetterState _letterState = LetterState.unknown;

  KeyboardButton(this._value, {Key? key}) : super(key: key);

  @override
  _KeyboardButtonState createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  @override
  Widget build(BuildContext context) {
    var gaime = context.watch<Wordle>();

    var letter = widget._value.codeUnitAt(0) - 65;
    var letterState = gaime.letterStates[letter];

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
            setState(() {
              gaime.addLetter(widget._value);
            });
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
