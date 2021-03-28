import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
                //utente loggato con google
                if (await GoogleSignIn().isSignedIn()) {
                  Auth().googleSignOut();
                }
                //utente loggato con facebook
                else if (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth
                            .instance.currentUser.providerData[0].providerId ==
                        "facebook.com") {
                  await Auth().facebookSignOut();
                }
                //utente loggato con email e password
                else {
                  await Auth().logOut();
                }

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
