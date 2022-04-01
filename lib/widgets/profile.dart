import 'package:flutter/material.dart';
import 'my_shared_preferences.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  //String hostname = "";
  String playerid = "";
  String playername = "";

  ProfileState() {
    //MySharedPreferences.instance
    //    .getStringValue("hostname")
    //    .then((value) => setState(() {
    //          hostname = value;
    //        }));
    MySharedPreferences.instance
        .getStringValue("playerid")
        .then((value) => setState(() {
              playerid = value;
            }));
    MySharedPreferences.instance
        .getStringValue("playername")
        .then((value) => setState(() {
              playername = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Text(
                //  "Host: " + hostname,
                //  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                //),
                //SizedBox(height: 30),
                Text(
                  "You are:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  playername,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 80),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: RaisedButton(
                      color: Colors.grey,
                      child: Text("Logout",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        MySharedPreferences.instance.removeAll();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
