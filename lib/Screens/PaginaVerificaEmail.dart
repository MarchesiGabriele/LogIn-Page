import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/Auth.dart';

//In questa pagina aspetto che l'utente confermi l'email di verifica, senza averla confermata non può procedere
//TODO: PROBLEMA: QUANDO VERIFICO L'EMAIL, SE SUBITO DOPO CLICCO REFRESH NON FUNZIONA, DEVO FARE UN HOT RELOAD O HOT RESTART PER FAR CAPIRE ALL APP CHE HO VERIFICATO
//TODO: decidere se voglio refreshare la pagina così da automaticamente capire quando l'utente verifica l'email oppure se voglio far cliccare un pulsante all'utente quando
//ha finito. NB: Se voglio capire sa solo quando viene verificata devo crearmi il codice da zero e ho sicuramente una generazione di più traffico verso il sito

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

  @override
  void initState() {
    super.initState();
    _messaggio = "";
    _messaggioInvio = "";
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
            //PULSANTE PER IL REFRESH
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  User user = FirebaseAuth.instance.currentUser;
                  await user.reload();
                  user = FirebaseAuth.instance.currentUser;
                  //Controllo che l'utente abbia verificato l'email
                  bool _stato = statoVerificaEmail(user);
                  print(user);

                  //TODO: capire se qua serve questo oppure se avviene un chage state e quindi un reinvio alla home automatico
                  if (_stato)
                    Navigator.pushNamed(context, Home.id);
                  else
                    setState(() {
                      _messaggio = "Account non è stato verificato, riprovare!";
                    });
                },
                child: const Text("Refresh Page"),
              ),
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
  bool statoVerificaEmail(user) {
    if (user.emailVerified) {
      print("UTENTE HA VERIFICATO EMAIL");
      return true;
    } else {
      print("UTENTE NON HA VERIFICATO EMAIL");
      return false;
    }
  }
}
