import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import '../widgets/my_shared_preferences.dart';
import '../environment_config.dart';

part 'game.g.dart';

@JsonSerializable()
@DataRepository([JSONServerAdapter])
class Game with DataModel<Game> {
  @override
  final int? id;
  final String word;
  final int guesses;
  final String playerid;
  final String playername;

  Game({this.id, required this.word, this.guesses = 0, required this.playerid, required this.playername});

  Game toggleGuesses() {
    return Game(id: this.id, word: this.word, guesses: this.guesses > 0 ? 0 : 1, playerid: this.playerid, playername: this.playername)
        .was(this);
  }
}

mixin JSONServerAdapter on RemoteAdapter<Game> {
  @override
  String get baseUrl => EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT;

  @override
  Future<Map<String, String>> get defaultHeaders async {
    String playerid = await MySharedPreferences.instance.getStringValue("playerid");
    return await super.defaultHeaders..addAll({'X-Client-ID': playerid});
  }

  @override
  String get identifierSuffix => 'Id';
}
