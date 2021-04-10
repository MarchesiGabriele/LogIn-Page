import 'package:flutter/material.dart';
import 'package:log/Screens/PaginaVerificaTelefono2.dart';
import 'package:log/Services/Auth.dart';

//TODO; questa pagina è molto simile a quella in cui si va a inserire il codice

//SCHEMA: Inserisco numero di telefono

class PaginaVerificaTelefono extends StatefulWidget {
  static final String id = "PaginaVerificaTelefono";
  final String title = "Verifica Numero Telefono";
  @override
  _PaginaVerificaTelefonoState createState() => _PaginaVerificaTelefonoState();
}

class _PaginaVerificaTelefonoState extends State<PaginaVerificaTelefono> {
  TextEditingController numeroController;
  String messaggio;

  @override
  void initState() {
    super.initState();
    numeroController = TextEditingController();
    messaggio = "";
  }

  void paginaSuccessiva() {
    Navigator.pushNamed(context, PaginaVerificaTelefono2.id);
  }

  @override
  Widget build(BuildContext context) {
    List _datiUtente = ModalRoute.of(context).settings.arguments;
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
                _datiUtente.add(numeroController.text);
                Navigator.pushNamed(context, PaginaVerificaTelefono2.id,
                    arguments: _datiUtente);
              },
              child: Text("Invia"),
            ),
            Text(messaggio),
          ],
        ),
      ),
    );
  }
}
