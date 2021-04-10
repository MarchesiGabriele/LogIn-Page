import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:log/Screens/Home.dart';

//TODO: Se ho delle eccezioni durante la creazione dell'account, fare qualcos'altro oltre a ritornare "null"
//
//NB: Se un utente possiede già un account creato con facebook con la stessa email, se cerca di entrare con google ci riesce,
//ma sovrascrive l'account di facebook, quindi successivamente non può più entrare con facebook.

class GoogleAuth extends StatelessWidget {
  Future<UserCredential> signInGoogle() async {
    //Creo credenziale per la creazione dell'account/login
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Provo a creare account/login con le credenziali create
    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("errore verifica google 1");
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
        text: "Sign In With Google",
        onPressed: () async {
          UserCredential user = await signInGoogle();
          if (user != null) {
            print("VERIFICA CON GOOGLE EFFETTUATA");
            Navigator.pushNamed(context, Home.id);
          } else {
            print("ERRORE VERIFICA CON GOOGLE");
          }
        },
        backgroundColor: Colors.red,
        image: Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7Orbk_hp4YopD2HHRn198vBdKgkvbqfVWYQ&usqp=CAU",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
