import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';
import '../models/guess.dart';

import 'keyboardbutton_widget.dart';

class KeyboardWidget extends ConsumerStatefulWidget {
  const KeyboardWidget({Key? key}) : super(key: key);

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends ConsumerState<KeyboardWidget> {
  String _word = "";

  @override
  void initState() {
    super.initState();
    _word = "HAIRY";
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.guesses.watchAll(params: {'_limit': 5}, syncLocal: true);

    return Column(
      children: [
        Row(
          children: [
            KeyboardButtonWidget('Q'),
            KeyboardButtonWidget('W'),
            KeyboardButtonWidget('E'),
            KeyboardButtonWidget('R'),
            KeyboardButtonWidget('T'),
            KeyboardButtonWidget('Y'),
            KeyboardButtonWidget('U'),
            KeyboardButtonWidget('I'),
            KeyboardButtonWidget('O'),
            KeyboardButtonWidget('P'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            KeyboardButtonWidget('A'),
            KeyboardButtonWidget('S'),
            KeyboardButtonWidget('D'),
            KeyboardButtonWidget('F'),
            KeyboardButtonWidget('G'),
            KeyboardButtonWidget('H'),
            KeyboardButtonWidget('J'),
            KeyboardButtonWidget('K'),
            KeyboardButtonWidget('L'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: TextButton(
                onPressed: () {
                  //setState(() {
                    Guess(letters: _word, playerid: "sPLSBgz").init(ref.read).save();
                  //});
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
            KeyboardButtonWidget('Z'),
            KeyboardButtonWidget('X'),
            KeyboardButtonWidget('C'),
            KeyboardButtonWidget('V'),
            KeyboardButtonWidget('B'),
            KeyboardButtonWidget('N'),
            KeyboardButtonWidget('M'),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    //gaime.backspace();
                  });
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