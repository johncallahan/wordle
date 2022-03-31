import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'main.data.dart';
import 'models/game.dart';

import 'widgets/wordle.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
      overrides: [configureRepositoryLocalStorage()],
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Wordle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WordleWidget(),
    );
  }
}
