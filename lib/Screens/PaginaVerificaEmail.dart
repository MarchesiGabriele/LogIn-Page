import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

//-IN QUESTA PAGINA ASPETTO CHE L'UTENTE VERIFICHI L'EMAIL. QUANDO LA CONFERMA VIENE AUTMATICAMENTE REINDERIZZATO SULLA PAGINA
//HOME.
//-SE NON VERIFICA PRIMA DELLO SCADERE DEL TEMPO L'ACCOUNT VIENE CANCELLATO E VIENE MANDATO ALLA PAGINA DI REGISTRAZIONE
//-SE NON VIENE EFFETTUATA LA VERIFICA PERCHE' L'UTENTE CHIUDE L'APP PRIMA DELLO SCADERE DEL TIMER L'ACCOUNT RIMANE CREATO.
//DEVO QUINDI LA PROSSIMA VOLTA CHE ENTRO NELL'APP CHIEDERE ALL'UTENTE DI VERIFICARE O DI CREARE UN NUOVO ACCOUNT.

class PaginaVerificaEmail extends StatefulWidget {
  static final String id = "PaginaVerificaEmail";
  final String _titolo = "Pagina Verifica Email";
  @override
  _PaginaVerificaEmailState createState() => _PaginaVerificaEmailState();
}

class _PaginaVerificaEmailState extends State<PaginaVerificaEmail> {
  //Messaggio di errore mostrato se l'utente clicca refresh e non ha ancora verificato l'email
  String _messaggio;
  //Messaggio che viene mostrato per indicare all'uente che gli è stata mandata un'altra email
  String _messaggioInvio;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _messaggio = "";
    _messaggioInvio = "";
    //Controllo periodicamente se l'email è stata verificata, quando viene verificata vado alla home
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        print("Controllo automatico verifica email..." + timer.tick.toString());
        //Se utente non verifica in tempo l'account lo cancello e lo rimado sulla pagina di registrazione
        if (timer.tick > 20) {
          print("TEMPO PER LA VERIFICA SCADUTO");
          FirebaseAuth.instance.currentUser.delete();
          print(
              "ACCOUNT UTENTE CANCELLATO PER MANCATA VERIFICA - TEMPO SCADUTO");
          dispose();
          Navigator.pushNamed(context, RegistrationPage.id);
        }
        statoVerificaEmail();
      },
    );
  }

  //Disattivo il timer
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget._titolo),
          leading: Container(),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Text(_messaggio),
            ),
            Container(
              child: Text("Abbiamo inviato una email a: " +
                  FirebaseAuth.instance.currentUser.email),
            ),
            //PULSANTE PER IL REINVIO DELL'EMAIL
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  await Auth().emailVerification();
                  setState(() {
                    _messaggioInvio = "Email è stata re-inviata";
                  });
                },
                child: const Text("Invia di nuovo l'email"),
              ),
            ),
            Container(
              child: Text(_messaggioInvio),
            ),
          ],
        ),
      ),
    );
  }

  //CONTROLLO SE EMAIL DI VERIFICA E' STATA CONFERMATA DALL'UTENTE O MENO
  void statoVerificaEmail() {
    User user = FirebaseAuth.instance.currentUser;
    user.reload();
    if (user.emailVerified) {
      print("UTENTE HA VERIFICATO EMAIL");
      dispose();
      Navigator.pushNamed(context, Home.id);
    }
  }
}
