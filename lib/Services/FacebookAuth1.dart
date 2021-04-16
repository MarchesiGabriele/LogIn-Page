import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'Auth.dart';

//In questa classe gestisco la logica per il il signIn e per il signOut con Facebook

//TODO: Se ho delle eccezioni durante la creazione dell'account, fare qualcos'altro oltre a ritornare "null"
//TODO: Se un utente è già registrato con l'email dell'account facebook viene lanciata un eccezione

class FacebookAuth1 {
  //FACEBOOK SIGN IN
  Future<UserCredential> signInFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
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

  //FACEBOOK SIGNOUT
  Future<void> facebookSignOut() async {
    try {
      await FacebookAuth.instance.logOut();
      await Auth().logOut();
      print("FACEBOOK LOG OUT AVVENUTO CON SUCCESSO");
    } catch (e) {
      print("FACEBOOK LOG OUT ERROR");
    }
  }
}
