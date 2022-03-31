import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.data.dart';

class Connected extends ConsumerStatefulWidget {
  const Connected({Key? key}) : super(key: key);

  @override
  _ConnectedState createState() => _ConnectedState();
}

class _ConnectedState extends ConsumerState<Connected> {
  Timer? timer;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkConnection());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkConnection() async {
    var url = Uri.parse('http://127.0.0.1:3000/games');
    try {
      var response = await http.get(url);
      setState(() { _connected = true; });
    } catch(_) {
      setState(() { _connected = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connected
      ? IconButton(icon: Icon(Icons.square), onPressed: () { checkConnection(); })
      : IconButton(icon: Icon(Icons.broken_image), onPressed: () { checkConnection(); });
  }
}
