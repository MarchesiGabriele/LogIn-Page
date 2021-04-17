import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Services/Auth.dart';

//IN QUESA PAGINA INIZIALIZZO FIREBASE E MANTENGO SOTTO'OCCHIO LO STATO DELL'UTENTE, SE QUESTO E' LOGGATO GLI MOSTRO LA HOME
//SE NON LO E' PIU' PERCHE' HA CANCELLATO L'ACCOUNT HO HA FATTO SIGN OUT ALLORA GLI MOSTRO LA PAGINA DI REGISTRAZIONE

class RootPage extends StatelessWidget {
  static const id = "RootPage";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: inizializzazioneApp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //Aspetto che finisca il caricamento dello stato utente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Controllando lo stato..."),
            ),
            body: null,
          );
          //Controllo se inizializzazione è andata a buon fine o meno
        } else if (snapshot.hasData && snapshot.data != false) {
          return StreamBuilder(
            //mi metto in ascolto dello stato dell'utente. Quando questo cambia il suo stato cambio la pagina in cui si trova
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot1) {
              if (snapshot1.data == null) {
                print("UTENTE NON LOGGATO O SENZA ACCOUNT");
                return RegistrationPage();
              } else {
                print("UTENTE LOGGATO");
                return Home();
              }
            },
          );
          //In caso di inizializzazione non eseguita mostro questa pagina
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Errore Avvio Applicazione"),
            ),
            body: null,
          );
        }
      },
    );
  }

  Future<bool> inizializzazioneApp() async {
    try {
      await Firebase.initializeApp();
      print("INIZIALIZZAZIONE ESEGUITA");
      return true;
    } catch (e) {
      print("INIZIALIZZAZIONE FALLITA");
      return false;
    }
  }
}
