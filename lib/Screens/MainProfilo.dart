import 'package:flutter/material.dart';
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
          title: Text("Sezione Profilo"),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
              },
              child: Text("cancella Account"),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () async {
                await Auth().logOut();
              },
              child: Text("Log off"),
            ))
          ],
        ),
      ),
    );
  }
}
