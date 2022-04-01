import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'my_shared_preferences.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  //TextEditingController controllerHostName = new TextEditingController();
  TextEditingController controllerPlayerId = new TextEditingController();

  Future<String> getPlayerName(String playerid) async {
    var url = Uri.parse('http://127.0.0.1:3000/players/${playerid}');
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['name'];
    } catch(_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.start,
                //  children: <Widget>[
                //    Text("Host:", style: TextStyle(fontSize: 18)),
                //    SizedBox(width: 20),
                //    Expanded(
                //      child: TextFormField(
                //          decoration: InputDecoration(
                //            hintText: "Please enter hostname",
                //          ),
                //          validator: (String? value) {
                //            if (value!.isEmpty) {
                //              return 'Hostname must not be empty';
                //            }
                //            return null;
                //          },
                //          controller: controllerHostName),
                //    )
                //  ],
                //),
                //SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Player Id:", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Please enter the Player Id",
                          ),
                          obscureText: false,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Player Id must not be empty';
                            }
                            return null;
                          },
                          controller: controllerPlayerId),
                    )
                  ],
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.grey,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      if(formKey.currentState!.validate()) {
                        //var getHostName = controllerHostName.text;
                        var getPlayerId = controllerPlayerId.text;
                        var playerName = await getPlayerName(getPlayerId);

                        if(playerName != "") {
                          //MySharedPreferences.instance
                          //    .setStringValue("hostname", getHostName);
                          MySharedPreferences.instance
                            .setStringValue("playerid", getPlayerId);
                          MySharedPreferences.instance
                            .setBooleanValue("loggedin", true);
                          MySharedPreferences.instance
                            .setStringValue("playername", playerName);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Profile()),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
