import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/wordle.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'keyboard_button.dart';

class Keyboard extends ConsumerStatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends ConsumerState<Keyboard> {
  @override
  Widget build(BuildContext context) {
    var gaime = ref.watch(wordleChangeNotifier);
    return Column(
      children: [
        Row(
          children: [
            KeyboardButton('Q'),
            KeyboardButton('W'),
            KeyboardButton('E'),
            KeyboardButton('R'),
            KeyboardButton('T'),
            KeyboardButton('Y'),
            KeyboardButton('U'),
            KeyboardButton('I'),
            KeyboardButton('O'),
            KeyboardButton('P'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            KeyboardButton('A'),
            KeyboardButton('S'),
            KeyboardButton('D'),
            KeyboardButton('F'),
            KeyboardButton('G'),
            KeyboardButton('H'),
            KeyboardButton('J'),
            KeyboardButton('K'),
            KeyboardButton('L'),
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
                    gaime.submitGuess();
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
            KeyboardButton('Z'),
            KeyboardButton('X'),
            KeyboardButton('C'),
            KeyboardButton('V'),
            KeyboardButton('B'),
            KeyboardButton('N'),
            KeyboardButton('M'),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    gaime.backspace();
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
