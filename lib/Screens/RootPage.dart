import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

class RootPage extends StatefulWidget {
  static final id = "RootPage";
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  //bool _authStatus = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Auth().firsUserStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Bitch"),
            ),
            body: null,
          );
        } else if (snapshot.hasData) {
          if (snapshot.data == false) {
            print("utente non loggato 1");
            return RegistrationPage();
          } else {
            print("utente loggato 1");
            return Home();
          }
        } else if (snapshot.data == null) {
          print("utente senza account 1");
          return RegistrationPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("errore"),
            ),
            body: null,
          );
        }
      },
    );
  }
}
