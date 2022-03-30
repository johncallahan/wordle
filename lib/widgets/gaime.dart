import 'package:flutter/material.dart';

import 'gaime_letter.dart';

class Gaime extends StatelessWidget {
  const Gaime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              GaimeLetter(0, 0),
              GaimeLetter(0, 1),
              GaimeLetter(0, 2),
              GaimeLetter(0, 3),
              GaimeLetter(0, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GaimeLetter(1, 0),
              GaimeLetter(1, 1),
              GaimeLetter(1, 2),
              GaimeLetter(1, 3),
              GaimeLetter(1, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GaimeLetter(2, 0),
              GaimeLetter(2, 1),
              GaimeLetter(2, 2),
              GaimeLetter(2, 3),
              GaimeLetter(2, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GaimeLetter(3, 0),
              GaimeLetter(3, 1),
              GaimeLetter(3, 2),
              GaimeLetter(3, 3),
              GaimeLetter(3, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GaimeLetter(4, 0),
              GaimeLetter(4, 1),
              GaimeLetter(4, 2),
              GaimeLetter(4, 3),
              GaimeLetter(4, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GaimeLetter(5, 0),
              GaimeLetter(5, 1),
              GaimeLetter(5, 2),
              GaimeLetter(5, 3),
              GaimeLetter(5, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
