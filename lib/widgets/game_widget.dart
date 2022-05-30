import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'my_shared_preferences.dart';

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
  String playerid = "";

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
      .getStringValue("playerid")
      .then((value) => setState(() {
          playerid = value;
        }));
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
              GameLetterWidget(playerid, 0, 0),
              GameLetterWidget(playerid, 0, 1),
              GameLetterWidget(playerid, 0, 2),
              GameLetterWidget(playerid, 0, 3),
              GameLetterWidget(playerid, 0, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(playerid, 1, 0),
              GameLetterWidget(playerid, 1, 1),
              GameLetterWidget(playerid, 1, 2),
              GameLetterWidget(playerid, 1, 3),
              GameLetterWidget(playerid, 1, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(playerid, 2, 0),
              GameLetterWidget(playerid, 2, 1),
              GameLetterWidget(playerid, 2, 2),
              GameLetterWidget(playerid, 2, 3),
              GameLetterWidget(playerid, 2, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(playerid, 3, 0),
              GameLetterWidget(playerid, 3, 1),
              GameLetterWidget(playerid, 3, 2),
              GameLetterWidget(playerid, 3, 3),
              GameLetterWidget(playerid, 3, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(playerid, 4, 0),
              GameLetterWidget(playerid, 4, 1),
              GameLetterWidget(playerid, 4, 2),
              GameLetterWidget(playerid, 4, 3),
              GameLetterWidget(playerid, 4, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              GameLetterWidget(playerid, 5, 0),
              GameLetterWidget(playerid, 5, 1),
              GameLetterWidget(playerid, 5, 2),
              GameLetterWidget(playerid, 5, 3),
              GameLetterWidget(playerid, 5, 4),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
