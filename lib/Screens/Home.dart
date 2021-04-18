import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/MainProfilo.dart';
import 'RegistrationPage.dart';

//IN QUESTA PAGINA VIENE MOSTRATA LA HOME

class Home extends StatefulWidget {
  final String _title = "Home";
  static String id = "Home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controllore per la PageView. Per prima pagina mostro la Home
  PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: userStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Un secondo..."),
                leading: Container(),
              ),
              body: null,
            );
          } else if (snapshot.hasData) {
            return PageView(
              controller: _pageController,
              children: <Widget>[
                //PAGINA FEED
                Scaffold(
                    appBar: AppBar(
                      title: const Text("Feed"),
                      leading: Container(),
                    ),
                    body: null),
                //PAGINA PRICIPALE
                Scaffold(
                  appBar: AppBar(
                    title: Text(widget._title),
                    leading: Container(),
                  ),
                  body: const Text("hey"),
                ),
                //SEZIONE PROFILO
                snapshot.data == false ? RegistrationPage() : MainProfilo(),
              ],
            );
          } else {
            //In caso di errore mostro questa pagina
            return Scaffold(
              appBar: AppBar(
                title: const Text("errore  "),
              ),
              body: null,
            );
          }
        },
      ),
    );
  }

  //CONTROLLO STATO UTENTE
  //Controllo se utente è loggato/ha un account. In questo modo so in anticipo se nella pagina profilo devo mostrare la pagina di
  //registrazione o il profilo dell'utente.
  Future<bool> userStatus() async {
    Stream stream = FirebaseAuth.instance.authStateChanges();
    User primoEvento = await stream.first;

    if (primoEvento == null)
      return false;
    else
      return true;
  }
}
