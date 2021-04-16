import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth {
  Future<void> verificaCodice(
      {String email, String password, @required String numeroTel}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+39$numeroTel",

      //Chiamato solamente quando il codice è verificato in automatico dal dispositivo android
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("VERIFICA AUTOMATICA EFFETTUATA!");
        await Auth().registrazioneEmail(email, password);
        print("ACCOUNT CON EMAIL E NUMERO CELL CREATO!");
        Navigator.pushNamed(context, Home.id);
      },

      //
      verificationFailed: (FirebaseException e) {
        print("NUMERO DI TEEFONO INSERITO NON VALIDO");
      },

      //Prendo messaggio di conferma da firebase per poterlo confrontare con quello dell utente
      codeSent: (String verificationId, int resendToken) {
        setState(() {
          print("GENERAZIONE CODICE IN CORSO");
          verificationCode = verificationId.toString();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
