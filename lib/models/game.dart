import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
@DataRepository([JSONServerAdapter])
class Game with DataModel<Game> {
  @override
  final int? id;
  final String word;
  final int guesses;

  Game({this.id, required this.word, this.guesses = 0});

  Game toggleGuesses() {
    return Game(id: this.id, word: this.word, guesses: this.guesses > 0 ? 0 : 1)
        .was(this);
  }
}

mixin JSONServerAdapter on RemoteAdapter<Game> {
  @override
  String get baseUrl => 'http://127.0.0.1:3000/';

  @override
  Future<Map<String, String>> get defaultHeaders async {
    //final token = await _localStorage.get('token');
    return await super.defaultHeaders..addAll({'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjQ4NTk1MTk2LCJleHAiOjE2NDk4OTExOTYsImp0aSI6IjQzZDFjZjRhLTU4YjQtNDViOS05NDE2LTI3YjU5MTYwYWRmYSJ9.3GXqoPk5XCJmvpS4iXmSPQt7BrVa0s2FopFuuvp4cHQ'});
  }

  @override
  String get identifierSuffix => 'Id';
}
