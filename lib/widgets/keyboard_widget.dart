import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'wordle_logic.dart';

import '../main.data.dart';
import '../models/guess.dart';

import 'keyboardbutton_widget.dart';

class KeyboardWidget extends ConsumerStatefulWidget {
  WordleLogic _logic;
  KeyboardWidget(this._logic, {Key? key}) : super(key: key);

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends ConsumerState<KeyboardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myLogic = ref.watch(logicChangeNotifier);
    WordleLogic _wordleLogic = widget._logic;
    final state = ref.guesses.watchAll(params: {'_limit': 5}, syncLocal: true);

    return Column(
      children: [
        Row(
          children: [
            KeyboardButtonWidget(_wordleLogic,'Q'),
            KeyboardButtonWidget(_wordleLogic,'W'),
            KeyboardButtonWidget(_wordleLogic,'E'),
            KeyboardButtonWidget(_wordleLogic,'R'),
            KeyboardButtonWidget(_wordleLogic,'T'),
            KeyboardButtonWidget(_wordleLogic,'Y'),
            KeyboardButtonWidget(_wordleLogic,'U'),
            KeyboardButtonWidget(_wordleLogic,'I'),
            KeyboardButtonWidget(_wordleLogic,'O'),
            KeyboardButtonWidget(_wordleLogic,'P'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            KeyboardButtonWidget(_wordleLogic,'A'),
            KeyboardButtonWidget(_wordleLogic,'S'),
            KeyboardButtonWidget(_wordleLogic,'D'),
            KeyboardButtonWidget(_wordleLogic,'F'),
            KeyboardButtonWidget(_wordleLogic,'G'),
            KeyboardButtonWidget(_wordleLogic,'H'),
            KeyboardButtonWidget(_wordleLogic,'J'),
            KeyboardButtonWidget(_wordleLogic,'K'),
            KeyboardButtonWidget(_wordleLogic,'L'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _wordleLogic.submitGuess(ref,_wordleLogic.currentGuess,state.model.length,true);
                    _wordleLogic.currentGuess = "";
                  });
                },
                child: const Text(
                  'ENTER',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                ),
              ),
            ),
            KeyboardButtonWidget(_wordleLogic,'Z'),
            KeyboardButtonWidget(_wordleLogic,'X'),
            KeyboardButtonWidget(_wordleLogic,'C'),
            KeyboardButtonWidget(_wordleLogic,'V'),
            KeyboardButtonWidget(_wordleLogic,'B'),
            KeyboardButtonWidget(_wordleLogic,'N'),
            KeyboardButtonWidget(_wordleLogic,'M'),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: TextButton(
                onPressed: () {
                  //setState(() {
                    _wordleLogic.backspace();
                  //});
                },
                child: const Icon(
                  Icons.backspace,
                  color: Colors.black,
                  size: 16.0,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
