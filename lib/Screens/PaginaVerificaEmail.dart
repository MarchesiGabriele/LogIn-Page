import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/Auth.dart';

//In questa pagina aspetto che l'utente confermi l'email di verifica, senza averla confermata non può procedere

//TODO: decidere se voglio refreshare la pagina così da automaticamente capire quando l'utente verifica l'email oppure se voglio far cliccare un pulsante all'utente quando
//ha finito. NB: Se voglio capire sa solo quando viene verificata devo crearmi il codice da zero e ho sicuramente una generazione di più traffico verso il sito

class PaginaVerificaEmail extends StatefulWidget {
  static final String id = "PaginaVerifiaEmail";
  @override
  _PaginaVerificaEmailState createState() => _PaginaVerificaEmailState();
}

class _PaginaVerificaEmailState extends State<PaginaVerificaEmail> {
  String _messaggio;
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
          title: Text("Verifica Email"),
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
            Container(
              child: ElevatedButton(
                //controllo che l'utente abbia verificato l'email
                //TODO: PROBLEMA: QUANDO VERIFICO L'EMAIL, SE SUBITO DOPO CLICCO REFRESH NON FUNZIONA, DEVO FARE UN HOT RELOAD O HOT RESTART PER FAR CAPIRE ALL APP CHE HO VERIFICATO
                onPressed: () async {
                  User user = FirebaseAuth.instance.currentUser;
                  await user.reload();
                  user = FirebaseAuth.instance.currentUser;
                  bool _stato = Auth().statoVerificaEmail(user);
                  print(user);
                  if (_stato)
                    Navigator.pushNamed(context, Home.id);
                  else
                    setState(() {
                      _messaggio = "Account non è stato verificato, riprovare!";
                    });
                },
                child: Text("Refresh Page"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  await Auth().emailVerification();
                  setState(() {
                    _messaggioInvio = "Email è stata inviata";
                  });
                },
                child: Text("Invia di nuovo l'email"),
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
}
