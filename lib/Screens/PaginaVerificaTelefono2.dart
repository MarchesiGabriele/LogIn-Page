import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/PaginaVerificaTelefono.dart';
import 'package:log/Services/Auth.dart';

import 'Home.dart';

//TODO; questa pagina è molto simile a quella in cui si va a inserire il codice
//
//ASPETTO IL METODO DI VERIFICA DEL NUMERO DI TELEFONO, NEL FRATTEMPO MOSTRO LA PAGINA IN CUI L'UTENTE PUO' INSERIRE IL CODICE DI VERIFICA, NEL FRATTEMPO SE IL METODO
//RITORNA UN ERRORE TORNO ALLA PAGINA IN CUI INSERIRE IL NUMERO, SE INVECE AVVIENE LA VERIFICA AUTOMATICA PASSO DIRETTAMENTE ALLA HOME
//Nel caso un utente sbagli il numero e voglia mandare un nuovo codice può usare il pulsante indietro per tornare alla pagina precedente

//TODO: usare un enum per indicare quello che può ritornare il future al posto di usare delle stringhe
//TODO: se ho un errore e devo ritornare alla PaginaVerificaTelefono, in quest'ultima pagina devo indicare che c'è stato un errore e che il numero era sbagliato

class PaginaVerificaTelefono2 extends StatefulWidget {
  static final String id = "PaginaVerificaTelefono2";
  final String title = "Verifica Numero Telefono";

  @override
  _PaginaVerificaTelefonoState2 createState() =>
      _PaginaVerificaTelefonoState2();
}

class _PaginaVerificaTelefonoState2 extends State<PaginaVerificaTelefono2> {
  TextEditingController numeroController;
  String messaggio;
  String verificationCode;

  @override
  void initState() {
    super.initState();
    numeroController = TextEditingController();
    messaggio = "";
    verificationCode = null;
  }

  //FUNZIONE DI VERIFICA DEL MESSAGGIO
  Future<void> verificaCodice(
      String email, String password, String numeroTel) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+39$numeroTel",

      //Chiamato solamente quando il codice è verificato in automatico dal dispositivo android
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("VERIFICA AUTOMATICA EFFETTUATA!");
        await Auth().registrazioneEmail(email, password);
        print("ACCOUNT CON EMAIL E NUMERO CELL CREATO!");
        Navigator.pushNamed(context, Home.id);
      },

      //
      verificationFailed: (FirebaseException e) {
        print("NUMERO DI TEEFONO INSERITO NON VALIDO");
      },

      //Prendo messaggio di conferma da firebase per poterlo confrontare con quello dell utente
      codeSent: (String verificationId, int resendToken) {
        setState(() {
          print("GENERAZIONE CODICE IN CORSO");
          verificationCode = verificationId.toString();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    List _infoUtente = ModalRoute.of(context).settings.arguments;
    print("numero telefono: ${_infoUtente.elementAt(2)}");
    return SafeArea(
      child: FutureBuilder(
        future: verificaCodice(
            _infoUtente.elementAt(0), _infoUtente.elementAt(1), "9996661478"),
        builder: (context, snapshot) {
          //ASPETTO CHE IL PROCESSO DI INVIO DEL MESSAGGIO AVVENGA
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Un secondo..."),
              ),
            );
          }
          //FACCIO INSERIRE IL CODICE ALL UTENTE E CONFERMO CHE SIA CORRETTO
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
                        "Abbiamo inviato un messaggio a 6 cifre a ${_infoUtente.elementAt(2)} inseriscilo per confermare il tuo account"),
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
                          AuthCredential cred = PhoneAuthProvider.credential(
                              verificationId: verificationCode,
                              smsCode: numeroController.text);
                          print(
                              "CODICE INSERITO E' CORRETTO, PROCEDO A CREARE ACCOUNT");
                          await Auth().registrazioneEmail(
                              _infoUtente.elementAt(0),
                              _infoUtente.elementAt(1));
                          print("ACCOUNT CON EMAIL E NUMERO CELL CREATO 22!");
                          Navigator.pushNamed(context, Home.id);
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
}
