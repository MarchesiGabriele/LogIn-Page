import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:log/Screens/Home.dart';

//TODO: Se ho delle eccezioni durante la creazione dell'account, fare qualcos'altro oltre a ritornare "null"
//  Se un utente è già registrato con l'email dell'account facebook viene lanciata un eccezione

class FacebookAuth1 extends StatelessWidget {
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: (MediaQuery.of(context).size.width - 300) / 4,
        top: 15,
      ),
      height: 40,
      width: 215,
      child: SignInButtonBuilder(
        text: "Sign In With Facebook",
        onPressed: () async {
          UserCredential user = await signInWithFacebook();
          if (user != null) {
            print("ACCESSO CON FACEBOOK EFFETTUATO");
            Navigator.pushNamed(context, Home.id);
          } else {
            print("ERRORE NELL'ACCESSO CON FACEBOOK");
          }
        },
        backgroundColor: Colors.blue,
        image: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Facebook_logo_%28square%29.png/480px-Facebook_logo_%28square%29.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
