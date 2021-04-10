import 'package:flutter/material.dart';
import 'package:log/Screens/MainProfilo.dart';
import 'package:log/Services/Auth.dart';
import 'RegistrationPage.dart';

//TODO: lo stato dell utente viene caricato ogni volta che si arriva su "home".

class Home extends StatefulWidget {
  static String id = "/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(initialPage: 1);
  static const String _title = "Home";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Auth().userStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Un secondo..."),
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
                      title: Text("Feed"),
                      leading: Container(),
                    ),
                    body: null),
                //PAGINA PRICIPALE
                Scaffold(
                  appBar: AppBar(
                    title: Text(_title),
                    leading: Container(),
                  ),
                  body: Text("hey"),
                ),
                //SEZIONE PROFILO
                snapshot.data == false ? RegistrationPage() : MainProfilo(),
              ],
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("errore  "),
              ),
              body: null,
            );
          }
        },
      ),
    );
  }
}
