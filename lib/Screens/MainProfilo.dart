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
<<<<<<< HEAD
            //CANCELLO ACCOUNT DA FIREBASE
=======
            //CANCELLAZIONE ACCOUNT
>>>>>>> 20363a8e4c99b57c19bfca532b1122fb52f43e1c
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
                Navigator.pushNamed(context, RegistrationPage.id);
              },
              child: Text("cancella Account"),
            ),
<<<<<<< HEAD
            //ESEGUO LOGOUT
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await Auth().logOut();
                  Navigator.pushNamed(context, Home.id);
                },
                child: Text("Log off"),
              ),
            )
=======
            //PULSANTE LOGOUT
            Center(
                child: ElevatedButton(
              onPressed: () async {
                await Auth().logOut();
                Navigator.pushNamed(context, RegistrationPage.id);
              },
              child: Text("Log off"),
            ))
>>>>>>> 20363a8e4c99b57c19bfca532b1122fb52f43e1c
          ],
        ),
      ),
    );
  }
}
