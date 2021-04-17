import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth.dart';

class PhoneAuth {
  String _codice;

  //Con questo metodo mando all'utente un codice. In caso di utente android può avvenire la verifica automatica, altrimenti
  //l'utente deve inserire manualmente il codice.
  Future<String> verificaCodice(
      {String email, String password, @required String numeroTel}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+39$numeroTel",

      //Chiamato solamente quando il codice è verificato in automatico dal dispositivo android
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("VERIFICA AUTOMATICA EFFETTUATA!");
        //Se l'utente ha confermato il codice e sta creando un account con email e password, creo account verificato.
        if (email != null && password != null) {
          await Auth().registrazioneEmail(email, password);
          print("ACCOUNT CON EMAIL E NUMERO CELL CREATO!");
          _codice = "emailVerificato";
        }
        //Se invece l'utente sta solamente verificando un account social ritorno la conferma di verifica account.
        else {
          _codice = "socialVerificato";
          print("VERIFICA ACCOUNT SOCIAL ESEGUITA!");
        }
      },

      //In caso di numero inserito incorretto o codice falso viene creato un errore
      verificationFailed: (FirebaseException e) {
        print("NUMERO DI TEEFONO INSERITO NON VALIDO");
        _codice = "errore";
      },

      //Prendo messaggio di conferma da firebase per poterlo confrontare con quello dell utente
      codeSent: (String verificationId, int resendToken) {
        print("GENERAZIONE CODICE IN CORSO");
        _codice = verificationId.toString();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    //Ritorno il codice per sapere cosa è successo dopo aver fatto partire la verifica
    //Se non ci sono errori e non è avvenuta la verifica automatica allora ritorno il codice che l'utente deve verificare
    return _codice;
  }
}
