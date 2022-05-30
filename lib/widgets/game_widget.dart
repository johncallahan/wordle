import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'gameletter_widget.dart';
import 'wordle_logic.dart';

import '../main.data.dart';
import '../models/game.dart';

class GameWidget extends StatefulHookConsumerWidget {
  WordleLogic _logic;
  GameWidget(this._logic, {Key? key}) : super(key: key);

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
    WordleLogic _wordleLogic = widget._logic;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          //SizedBox(height: 35),
          SizedBox(height: 5),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 0, 0),
              GameLetterWidget(_wordleLogic, 0, 1),
              GameLetterWidget(_wordleLogic, 0, 2),
              GameLetterWidget(_wordleLogic, 0, 3),
              GameLetterWidget(_wordleLogic, 0, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 1, 0),
              GameLetterWidget(_wordleLogic, 1, 1),
              GameLetterWidget(_wordleLogic, 1, 2),
              GameLetterWidget(_wordleLogic, 1, 3),
              GameLetterWidget(_wordleLogic, 1, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 2, 0),
              GameLetterWidget(_wordleLogic, 2, 1),
              GameLetterWidget(_wordleLogic, 2, 2),
              GameLetterWidget(_wordleLogic, 2, 3),
              GameLetterWidget(_wordleLogic, 2, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 3, 0),
              GameLetterWidget(_wordleLogic, 3, 1),
              GameLetterWidget(_wordleLogic, 3, 2),
              GameLetterWidget(_wordleLogic, 3, 3),
              GameLetterWidget(_wordleLogic, 3, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 4, 0),
              GameLetterWidget(_wordleLogic, 4, 1),
              GameLetterWidget(_wordleLogic, 4, 2),
              GameLetterWidget(_wordleLogic, 4, 3),
              GameLetterWidget(_wordleLogic, 4, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(_wordleLogic, 5, 0),
              GameLetterWidget(_wordleLogic, 5, 1),
              GameLetterWidget(_wordleLogic, 5, 2),
              GameLetterWidget(_wordleLogic, 5, 3),
              GameLetterWidget(_wordleLogic, 5, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
