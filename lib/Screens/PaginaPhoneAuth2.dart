import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/PaginaPhoneAuth1.dart';
import 'package:log/Services/Auth.dart';
import 'package:log/Services/PhoneAuth.dart';

import 'Home.dart';

//VERIFICO ACCOUNT CON NUMERO DI TELEFONO. L'ACCOUNT ARRIVATO A QUESTO PUNTO E' GIA' CREATO, SE LA VERIFICA AVVIENE ALLORA 
//PROCEDO E VADO ALLA HOME, ALTRIMENTI SE VERIFICA NON VIENE COMPLETATA O NON E' CORRETTO IL CODICE ELIMINO ACCOUNT E MANDO UTENTE
//ALLA REGISTRATION PAGE.

class PaginaPhoneAuth2 extends StatefulWidget {
  PaginaPhoneAuth2({this.email, this.password, @required this.numeroTel});
  final String email;
  final String password;
  final String numeroTel;

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
  @override
  void initState() {
    super.initState();
    numeroController = TextEditingController();
    messaggio = "";    
  }

  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: FutureBuilder(
        //Controllo se ho anche password ed email o solo numero telefono, in base a quello mando solamente i dati che possiedo
        future: widget.password == null
            ? verifyPhone(numeroTelefono: widget.numeroTel, email: widget.email)
            : verifyPhone(
                email: widget.email,
                password: widget.password,
                numeroTelefono: widget.numeroTel),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Aspetto che la pagina carichi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Un secondo..."),
              ),
            );
          }
          //Faccio inserire il codice all'utente e confermo che sia corretto
          else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Verifica Telefono 2"),
                ),
                body: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "Abbiamo inviato un messaggio a 6 cifre a ${widget.email} inseriscilo per confermare il tuo account"),
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

  
  //Se utente viene verificato automaticamente lo mando alla home e gli aggiorno il profilo con "emailVerified" = true
  void verificationCompletedAction(PhoneAuthCredential credentials){
    print("VERIFICA SMS AUTOMATICA EFFETTUTA!");
    Navigator.pushNamed(context, Home.id);       
    FirebaseAuth.instance.

  }

  //Se verifica fallisce mando utente a inserire nuovamente il numero di telefono
  void verificationFailedAction(){    
    print("VERIFICA SMS FALLITA!");
    Builder(builder: (context) => PaginaPhoneAuth1(email: widget.email, password: widget.password,),);
  }

  Future<void> verifyPhone({@required String email, String password, @required String numeroTelefono}) async{
      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: widget.numeroTel,
      verificationCompleted: verificationCompletedAction,
      verificationFailed: null,
      codeSent: null,
      codeAutoRetrievalTimeout: null);

  }
}

