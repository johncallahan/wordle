import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/wordle.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Wordle(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wordle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WordleWidget(),
    );
  }
}
