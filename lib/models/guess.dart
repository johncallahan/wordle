import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import '../widgets/my_shared_preferences.dart';
import '../environment_config.dart';

part 'guess.g.dart';

@JsonSerializable()
@DataRepository([JSONServerAdapter])
class Guess with DataModel<Guess> {
  @override
  final int? id;
  final String letters;
  final String playerid;

  Guess({this.id, required this.letters, required this.playerid});
}

mixin JSONServerAdapter on RemoteAdapter<Guess> {
  @override
  String get baseUrl => EnvironmentConfig.BASE_PROTOCOL + "://" + EnvironmentConfig.BASE_HOST + ":" + EnvironmentConfig.BASE_PORT;

  @override
  String urlForFindAll(Map<String, dynamic> params) {
    return "guesses";
  }

  @override
  Future<Map<String, String>> get defaultHeaders async {
    String playerid = await MySharedPreferences.instance.getStringValue("playerid");
    return await super.defaultHeaders..addAll({'X-Client-ID': playerid});
  }

  @override
  String get identifierSuffix => 'Id';
}
