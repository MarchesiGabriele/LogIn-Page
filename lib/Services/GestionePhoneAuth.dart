/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GestionePhoneAuth extends StatelessWidget {
  Future<void> phoneAuth(String numeroTel) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: numeroTel,

      //Per utenti ANDROID verifico codice sms in automatico, senza che utente debba inserire il codice
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        return "utente_verificato";
      },

      //In caso di numero sbagliato o altri errori
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        return "errore_verifica";
      },

      //Verifica del codice
      codeSent: (String verificationId, int resendToken) async {
        String _codice = await getCodiceConferma();

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: _codice);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(phoneAuthCredential);
      },

      //Tempo in cui il telefono cerca il codice di autenticazione automaticamente
      codeAutoRetrievalTimeout: (String verificationId) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: phoneAuth(numeroTel),
      ),
    );
  }
}
 */