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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Quando un utente apre l'app controllo lo stato, se è loggato lo mando nella home altrimenti lo mando nella pagina registrazione
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
            print("utente non loggato");
            return RegistrationPage();
          } else {
            print("utente loggato");
            return Home();
          }
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
