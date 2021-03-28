import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/PaginaVerificaEmail.dart';
import 'package:log/Services/Auth.dart';

//CHIEDO ALL'UTENTE SE VUOLE VERIFICARE ACCOUNT CON EMAIL O CON NUMERO DI TELEFONO

//TODO: Al posto di chiamare chiamare "Verifica Email" da qua lo dovrei fare dopo essere arrivato nella pagina di verifica
//dell'email, almeno non devo aspettare nel caricare quella pagina

class SceltaVerificaAccount extends StatelessWidget {
  static final String id = "SceltaVerificaAccount";
  final String _titolo = "Scelta Verifica Account";

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    child: const Text("Verifica con numero di Telefono")),
                const SizedBox(
                  height: 50,
                ),
                //VERIFICA CON EMAIL
                ElevatedButton(
                    onPressed: () async {
                      UserCredential p = await Auth().registrazioneEmail(
                        _datiUtente.elementAt(0),
                        _datiUtente.elementAt(1),
                      );
                      print(p.user.email);
                      //invio email conferma
                      await Auth().emailVerification();
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
}
