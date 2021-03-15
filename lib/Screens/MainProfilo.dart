import 'package:flutter/material.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

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
            //CANCELLAZIONE ACCOUNT
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
