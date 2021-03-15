import 'package:flutter/material.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

import 'Home.dart';

class MainProfilo extends StatefulWidget {
  @override
  _MainProfiloState createState() => _MainProfiloState();
}

class _MainProfiloState extends State<MainProfilo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sezione Profilo"),
          leading: Container(),
        ),
        body: Column(
          children: <Widget>[
            //CANCELLO ACCOUNT DA FIREBASE
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
                Navigator.pushNamed(context, RegistrationPage.id);
              },
              child: Text("cancella Account"),
            ),
            //PULSANTE LOGOUT
            Center(
                child: ElevatedButton(
              onPressed: () async {
                await Auth().logOut();
                Navigator.pushNamed(context, RegistrationPage.id);
              },
              child: Text("Log off"),
            ))
          ],
        ),
      ),
    );
  }
}
