import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/PaginaVerificaEmail.dart';
import 'package:log/Screens/PaginaVerificaTelefono.dart';
import 'package:log/Services/Auth.dart';

//CHIEDO ALL'UTENTE SE VUOLE VERIFICARE ACCOUNT CON EMAIL O CON NUMERO DI TELEFONO

//TODO: Al posto di chiamare chiamare "Verifica Email" da qua lo dovrei fare dopo essere arrivato nella pagina di verifica
//dell'email, almeno non devo aspettare nel caricare quella pagina

//TODO: il controllo della password e del fatto che l'email esista

class SceltaVerificaAccount extends StatelessWidget {
  static final String id = "SceltaVerificaAccount";
  final String _titolo = "Scelta Verifica Account";

  @override
  Widget build(BuildContext context) {
    //Argomenti: (0) Email, (1) Password
    List _datiUtente = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(_titolo),
          ),
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 200,
                  child: const Text("Scegli come verificare il tuo account: "),
                ),
                //VERIFICA CON NUMERO DI TELEFONO
                ElevatedButton(
                  onPressed: () async {
                    //Creo account con email e password.
                    UserCredential p = await registrazioneEmail(
                      _datiUtente.elementAt(0),
                      _datiUtente.elementAt(1),
                    );

                    print("CREATO ACCOUNT: " +
                        p.user.email +
                        " ORA PROCEDO ALLA VERIFICA CON SMS");
                  },
                  child: const Text("Verifica con numero di Telefono"),
                ),
                const SizedBox(
                  height: 50,
                ),
                //VERIFICA CON EMAIL
                ElevatedButton(
                    onPressed: () async {
                      //Creo account con email e password.
                      UserCredential p = await registrazioneEmail(
                        _datiUtente.elementAt(0),
                        _datiUtente.elementAt(1),
                      );
                      print("CREATO ACCOUNT: " +
                          p.user.email +
                          " ORA PROCEDO ALL'INVIO EMAIL DI CONFERMA");

                      //Invio email conferma
                      await emailVerification();
                      Navigator.pushNamed(
                        context,
                        PaginaVerificaEmail.id,
                      );
                    },
                    child: const Text("Verifica con email")),
              ],
            ),
          )),
    );
  }

  //CREAZIONE ACCOUNT CON EMAIL
  Future<UserCredential> registrazioneEmail(
      String email, String password) async {
    //Creo account con email e password
    try {
      print("CREAZIONE ACCOUNT: " + email + " PASS: " + password);
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
        print("Eccezione sconosciuta SceltaVerificaAccount");
        return null;
      }
    } catch (e) {
      print("Errore Sconosciuto SceltaVerificaAccount");
      return null;
    }
  }

  //INVIO EMAIL DI VERIFICA
  Future<void> emailVerification() async {
    User user = FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
    print("EMAIL DI CONFERMA INVIATA");
  }
}
