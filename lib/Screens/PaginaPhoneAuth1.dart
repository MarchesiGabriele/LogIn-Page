import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Services/Auth.dart';

import 'PaginaPhoneAuth2.dart';

//IN QUESTA PAGINA L'UTENTE INSERISCE IL PROPRIO NUMERO DI TELEFONO PER POTER RICEVERE IL CODICE

//TODO forse posso usare in qualche modo un inherited widget per avere sempre a disposizione email e password nel caso ci siano
//SCHEMA: Inserisco numero di telefono

class PaginaPhoneAuth1 extends StatefulWidget {
  PaginaPhoneAuth1({this.email, this.password});
  final String email;
  final String password;

  static final String id = "PaginaPhoneAuth1";
  final String title = "Verifica Numero Telefono";
  @override
  _PaginaPhoneAuth1State createState() => _PaginaPhoneAuth1State();
}

class _PaginaPhoneAuth1State extends State<PaginaPhoneAuth1> {
  //Controllore per campo di testo
  TextEditingController numeroController;
  //Stringa per indicare errori da mostrare all'utente
  String messaggio;
  String _userEmail;

  @override
  void initState() {
    super.initState();
    numeroController = TextEditingController();
    messaggio = "";
    //Controllo se conosco già l'email dell'utente. Se sta verificando un account social allora la devo ancora scoprire
    if (widget.email == null) {
      _userEmail = FirebaseAuth.instance.currentUser.email;
    } else {
      _userEmail = widget.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
                "Inserisci il numero di telefono: \nTi Invieremo un codice via sms"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 30, left: 20),
              height: 50,
              width: 350,
              child: TextField(
                controller: numeroController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //Controllo validità del numero di telefono
                if (numeroController.text.trim().length != 10)
                  setState(() {
                    messaggio = "Numero di telefono invalido";
                  });

                //Passo alla pagina successiva di verifica passando gli argomenti
                //Se ho ancora la password passo anche quella perchè sto verificando un account creato con pass e email
                //Se invece ho solo l'email allora significa che sto verificanfo un account social
                Builder(
                  builder: (context) => widget.password == null
                      ? PaginaPhoneAuth2(
                          email: _userEmail,
                          numeroTel: numeroController.text.trim())
                      : PaginaPhoneAuth2(
                          email: _userEmail,
                          password: widget.password,
                          numeroTel: numeroController.text.trim()),
                );
              },
              child: const Text("Invia"),
            ),
            //Mostro un messaggio di errore in caso ce ne sia uno
            Text(messaggio),
          ],
        ),
      ),
    );
  }
}
