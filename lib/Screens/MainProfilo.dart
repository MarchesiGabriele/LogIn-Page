import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';
import 'package:log/Services/FacebookAuth1.dart';
import 'package:log/Services/GoogleAuth.dart';

class MainProfilo extends StatefulWidget {
  final String _title = "Sezione Profilo";
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
          title: Text(widget._title),
          leading: Container(),
        ),
        body: Column(
          children: <Widget>[
            //CANCELLO ACCOUNT
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
                Navigator.pushNamed(context, RegistrationPage.id);
              },
              child: Text("cancella Account"),
            ),
            //ESEGUO SIGN_OUT
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String _provider = "";
                  if (FirebaseAuth.instance.currentUser != null) {
                    _provider = FirebaseAuth
                        .instance.currentUser.providerData[0].providerId;
                  }

                  //utente loggato con google
                  if (_provider == "google.com") {
                    await GoogleAuth().signOutGoogle();
                  }
                  //utente loggato con facebook
                  else if (_provider == "facebook.com") {
                    await FacebookAuth1().facebookSignOut();
                  }
                  //utente loggato con email e password
                  else {
                    await Auth().logOut();
                  }

                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                child: Text("Log off"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
