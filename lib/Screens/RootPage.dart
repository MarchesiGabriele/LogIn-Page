import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

class RootPage extends StatelessWidget {
  static const id = "RootPage";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Quando un utente apre l'app controllo lo stato, se è loggato lo mando nella home altrimenti lo mando nella pagina registrazione
      future: Auth().firsUserStatus(),
      builder: (context, snapshot) {
        //Aspetto che finisca il caricamento dello stato utente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Controllando lo stato..."),
            ),
            body: null,
          );
        } else if (snapshot.hasData) {
          if (snapshot.data == false) {
            print("UTENTE NON LOGGATO");
            return RegistrationPage();
          } else {
            print("UTENTE LOGGATO");
            return Home();
          }
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Errore caricamento stato utente"),
            ),
            body: null,
          );
        }
      },
    );
  }
}
