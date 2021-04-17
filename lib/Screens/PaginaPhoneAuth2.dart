import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Services/Auth.dart';
import 'package:log/Services/PhoneAuth.dart';

//IN QUESTA PAGINA L'UTENTE INSERISCE IL CODICE DI CONFERMA RICEVUTO

class PaginaPhoneAuth2 extends StatefulWidget {
  static final String id = "PaginaPhoneAuth2";
  final String title = "Verifica Numero Telefono";
  @override
  _PaginaPhoneAuth2State createState() => _PaginaPhoneAuth2State();
}

class _PaginaPhoneAuth2State extends State<PaginaPhoneAuth2> {
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
    //Ricevo argomenti con (0) Email (Opzionale), (1) Password (Opzionale), (2) Numero Telefono (Obbligatorio)
    _datiUtente = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: FutureBuilder(
        //Controllo se ho anche password ed email o solo numero telefono, in base a quello mando solamente i dati che possiedo
        future: _datiUtente.length == 1
            ? verifyPhone(numeroTelefono: _datiUtente.elementAt(0))
            : verifyPhone(
                email: _datiUtente.elementAt(0),
                password: _datiUtente.elementAt(1),
                numeroTelefono: _datiUtente.elementAt(2)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Aspetto che la pagina carichi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Un secondo..."),
              ),
            );
          }
          //Faccio inserire il codice all'utente e confermo che sia corretto
          else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Verifica Telefono 2"),
                ),
                body: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "Abbiamo inviato un messaggio a 6 cifre a ${_datiUtente.length == 1 ? _datiUtente.elementAt(0) : _datiUtente.elementAt(2)} inseriscilo per confermare il tuo account"),
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
                      onPressed: () async {
                        try {
                          if()

                          /* AuthCredential cred = PhoneAuthProvider.credential(
                              //Dentro snapshot.data ho il codice che firebase ha mandato all'utente e che deve essere uguale
                              //a quello che inserisce per effettuare la verifica
                              verificationId: snapshot.data,
                              smsCode: numeroController.text);
                          print(
                              "CODICE INSERITO E' CORRETTO, PROCEDO A CREARE ACCOUNT");
                          await Auth().registrazioneEmail(
                              _infoUtente.elementAt(0),
                              _infoUtente.elementAt(1));
                          print("ACCOUNT CON EMAIL E NUMERO CELL CREATO 22!");
                          Navigator.pushNamed(context, Home.id); */
                        } catch (e) {
                          print("CODICE INSERITO E' ERRATO");
                        }
                      },
                      child: Text("Verifica"),
                    ),
                    Text(messaggio),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> verifyPhone({String email, String password, @required String numeroTelefono}) async{

      


    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)

  }
}

/* SafeArea(
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
                Navigator.pushNamed(context, PaginaPhoneAuth2.id,
                    arguments: _datiUtente);
              },
              child: Text("Invia"),
            ),
            Text(messaggio),
          ],
        ),
      ),
    ); */
