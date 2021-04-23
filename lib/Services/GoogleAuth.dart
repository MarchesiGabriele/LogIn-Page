import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';

import 'Auth.dart';

//In questa classe gestisco la logica per il signIn e per il signOut con Google

//TODO: Se ho delle eccezioni durante la creazione dell'account, fare qualcos'altro oltre a ritornare "null"
//
//Se un utente possiede già un account creato con facebook con la stessa email, se cerca di entrare con google ci riesce,
//ma sovrascrive l'account di facebook. Se un utente ha creato un account con email e password non ci sono problemi

class GoogleAuth {
  //GOOGLE SIGN IN
  Future<UserCredential> signInGoogle() async {
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("ACCOUNT CON STESSA EMAIL GIA' PRESENTE");
        return null;
      } else if (e.code == 'invalid-credential') {
        print("errore verifica google 2");
        return null;
      } else {
        print("errore verifica google 3");
        return null;
      }
    }
  }

  //GOOGLE SIGNOUT
  Future<void> signOutGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await Auth().logOut();
      print("GOOGLE LOG OUT AVVENUTO CON SUCCESSO");
    } catch (e) {
      print("GOOGLE LOG OUT ERROR");
    }
  }
}
