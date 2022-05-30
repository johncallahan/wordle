import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'gameletter_widget.dart';
import 'wordle_logic.dart';

import '../main.data.dart';
import '../models/game.dart';

class GameWidget extends StatefulHookConsumerWidget {
  GameWidget({Key? key}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends ConsumerState<GameWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myLogic = ref.watch(logicChangeNotifier);
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          //SizedBox(height: 35),
          SizedBox(height: 5),
          Row(
            children: [
              GameLetterWidget(0, 0),
              GameLetterWidget(0, 1),
              GameLetterWidget(0, 2),
              GameLetterWidget(0, 3),
              GameLetterWidget(0, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(1, 0),
              GameLetterWidget(1, 1),
              GameLetterWidget(1, 2),
              GameLetterWidget(1, 3),
              GameLetterWidget(1, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(2, 0),
              GameLetterWidget(2, 1),
              GameLetterWidget(2, 2),
              GameLetterWidget(2, 3),
              GameLetterWidget(2, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(3, 0),
              GameLetterWidget(3, 1),
              GameLetterWidget(3, 2),
              GameLetterWidget(3, 3),
              GameLetterWidget(3, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(4, 0),
              GameLetterWidget(4, 1),
              GameLetterWidget(4, 2),
              GameLetterWidget(4, 3),
              GameLetterWidget(4, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(5, 0),
              GameLetterWidget(5, 1),
              GameLetterWidget(5, 2),
              GameLetterWidget(5, 3),
              GameLetterWidget(5, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
