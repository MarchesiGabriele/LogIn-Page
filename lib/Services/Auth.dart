import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:log/Screens/PaginaVerificaTelefono2.dart';

//NB!! USARE METODO DI USER "REAUTHENTICATE" PER QUANDO SI VUOLE EFFETTUARE UNA VERIFICA CHE L'UTENTE CHE VUOLE EFFETTUARE LA MODIFICA SIA I PROPRIETARIO DELL ACCOUNT

//TODO: Rimuovere il captcha quando si esegue la verifica con numero di telefono

//TODO: QUANDO UN UTENTE SI REGISTRA GLI MANDO UN'EMAIL E PER ENTRARE NELL APP DEVE FARE IL LOGIN. QUESTO LOGIN VIENE ACCETTATO
//SOLO SE L'EMAIL E' STATA VERIFICATA, SE NON E' STATA VERIFICATA MANDO UN ERRORE E FACCIO APPARIRE PULSANTE CHE PERMETTE DI
//INVIARE L'EMAIL DI VERIFICA NUOVAMENTE

class Auth {
  //REGISTRAZIONE CON EMAIL SENZA VERIFICA
  Future<UserCredential> registrazioneEmail(
      String email, String password) async {
    //creo account con email e password
    try {
      print(email + password);
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return usercredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      } else {
        print("errore sconosciuto");
        return null;
      }
    } catch (e) {
      print("pera");
      return null;
    }
  }

//INVIO EMAIL DI VERIFICA
  Future<void> emailVerification() async {
    User user = FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
  }

  //CONTROLLO STATO UTENTE QUANDO APRE L'APPLICAZIONE
  Future<bool> firsUserStatus() async {
    //inizializzo applicazione
    try {
      await Firebase.initializeApp();
      print("inizializzazine app");
    } catch (e) {
      print("app non inizializzata");
      return null;
    }
    //eseguo il controllo dello stato dell' utente
    return await userStatus();
  }

  //CONTROLLO STATO UTENTE
  Future<bool> userStatus() async {
    //controllo se l'utente è loggato e se ha un account, se non ce l'ha o non è loggato ritorno false
    //stream restituisce "User" se l'utente è loggato e "Null" se non lo è o se non ha un account
    Stream stream = FirebaseAuth.instance.authStateChanges();
    User primoEvento = await stream.first;

    if (primoEvento == null) {
      print("UTENTE NON LOGGATO/SENZA ACCOUNT");
      return false;
    } else {
      print("UTENTE LOGGATO");
      print(primoEvento);
      return true;
    }
  }

  //CANCELLO ACCOUNT DELL'UTENTE
  Future<void> deleteUser() async {
    try {
      User user = FirebaseAuth.instance.currentUser;

      if (user != null) await user.delete();
      print("utente eliminato ");
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //UTENTE ESCE DAL PROPRIO ACCOUNT
  Future<void> logOut() async {
    try {
      FirebaseAuth user = FirebaseAuth.instance;
      await user.signOut();
      print("UTENTE HA ESEGUITO SIGNOUT TRADIZIONALE");
    } catch (e) {
      print("ERRORE SIGN OUT TRADIZIONALE");
    }
  }

  //ESEGUO LOGIN
  Future<String> loginWithEmail(String email, String password) async {
    print("sos");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "ok";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "No user found for that email";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong password provided for that user";
      } else {
        return "errore";
      }
    }
  }
}
