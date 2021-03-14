import 'package:flutter/material.dart';
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
          title: Text("Sezione Profilo"),
        ),
        body: Column(
          children: <Widget>[
            //CANCELLO ACCOUNT DA FIREBASE
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
              },
              child: Text("cancella Account"),
            ),
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
          ],
        ),
      ),
    );
  }
}
