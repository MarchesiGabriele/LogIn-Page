import 'package:flutter/material.dart';
import 'package:log/Screens/LoginPage.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Screens/SceltaVerificaAccount.dart';
import 'Screens/Home.dart';
import 'Screens/RootPage.dart';
import 'Screens/PaginaVerificaEmail.dart';
import 'Screens/SceltaVerificaAccount.dart';
//SCHEMA:
/* Entro nell'account e controllo se ho un account: 
    Se non ho un account -> pagina creazione account
    Se ho un account contorllo se è fatto il login
      Se è fatto allora -> Home page
      Se non è fatto allora -> pagina login
*/

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Log",
      //con rootpage controllo se l'utente ha un account o meno e se lo ha controllo se ha fatto il login
      initialRoute: RootPage.id,
      routes: {
        RegistrationPage.id: (BuildContext context) => RegistrationPage(),
        Home.id: (BuildContext context) => Home(),
        RootPage.id: (BuildContext context) => RootPage(),
        LoginPage.id: (BuildContext context) => LoginPage(),
        PaginaVerificaEmail.id: (BuildContext context) => PaginaVerificaEmail(),
        SceltaVerificaAccount.id: (BuildContext context) =>
            SceltaVerificaAccount()
      },
    );
  }
}
