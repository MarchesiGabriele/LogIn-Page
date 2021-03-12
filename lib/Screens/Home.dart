import 'package:flutter/material.dart';
import 'package:log/Screens/MainProfilo.dart';
import 'package:log/Services/Auth.dart';
import 'RegistrationPage.dart';

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
      child: PageView(
        controller: _pageController,
        children: <Widget>[
          //PAGINA FEED
          Scaffold(
              appBar: AppBar(
                title: Text("Feed"),
              ),
              body: null),
          //PAGINA PRICIPALE
          Scaffold(
            appBar: AppBar(
              title: Text(_title),
            ),
            body: Text("hey"),
          ),
          //SEZIONE PROFILO
          FutureBuilder(
            future: Auth().userStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Un secondo..."),
                  ),
                  body: null,
                );
              } else if (snapshot.hasData) {
                if (snapshot.data == null || snapshot.data == false) {
                  return RegistrationPage();
                } else {
                  return MainProfilo();
                }
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("errore  "),
                  ),
                  body: null,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
