import 'package:flutter/material.dart';

import 'game_letter.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              GameLetter(0, 0),
              GameLetter(0, 1),
              GameLetter(0, 2),
              GameLetter(0, 3),
              GameLetter(0, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetter(1, 0),
              GameLetter(1, 1),
              GameLetter(1, 2),
              GameLetter(1, 3),
              GameLetter(1, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetter(2, 0),
              GameLetter(2, 1),
              GameLetter(2, 2),
              GameLetter(2, 3),
              GameLetter(2, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetter(3, 0),
              GameLetter(3, 1),
              GameLetter(3, 2),
              GameLetter(3, 3),
              GameLetter(3, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetter(4, 0),
              GameLetter(4, 1),
              GameLetter(4, 2),
              GameLetter(4, 3),
              GameLetter(4, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetter(5, 0),
              GameLetter(5, 1),
              GameLetter(5, 2),
              GameLetter(5, 3),
              GameLetter(5, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
