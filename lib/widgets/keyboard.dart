import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/wordle.dart';

import 'keyboard_button.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
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
                    Provider.of<Wordle>(context, listen: false).submitGuess();
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
                    Provider.of<Wordle>(context, listen: false).backspace();
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
