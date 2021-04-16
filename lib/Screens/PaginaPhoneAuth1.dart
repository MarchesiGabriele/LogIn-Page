import 'package:flutter/material.dart';
import 'package:log/Services/Auth.dart';

import 'PaginaPhoneAuth2.dart';

//IN QUESTA PAGINA L'UTENTE INSERISCE IL PROPRIO NUMERO DI TELEFONO PER POTER RICEVERE IL CODICE

//TODO forse posso usare in qualche modo un inherited widget per avere sempre a disposizione email e password nel caso ci siano
//SCHEMA: Inserisco numero di telefono

class PaginaPhoneAuth1 extends StatefulWidget {
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
  List _datiUtente;

  @override
  void initState() {
    super.initState();
    numeroController = TextEditingController();
    messaggio = "";
    _datiUtente = [];
  }

  @override
  Widget build(BuildContext context) {
    //Se arrivo da creazione account con email e password, prendo ricevo questi argomenti, altrimenti non ricevo nulla
    if (ModalRoute.of(context).settings.arguments != null)
      _datiUtente = ModalRoute.of(context).settings.arguments;
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
              //TODO: Devo decidere cosa mostrare mentre attendo, dato che non so cosa riceverò.
              onPressed: () {
                //Aggiungo ai parametri da passare alla prossima pagina il numero di telefono
                _datiUtente.add(numeroController.text);
                //Passo alla pagina successiva di verifica passando gli argomenti
                Navigator.pushNamed(context, PaginaPhoneAuth2.id,
                    arguments: _datiUtente);
              },
              child: Text("Invia"),
            ),
            //Mostro un messaggio di errore in caso ce ne sia uno
            Text(messaggio),
          ],
        ),
      ),
    );
  }
}
