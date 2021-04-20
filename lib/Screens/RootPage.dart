import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/RegistrationPage.dart';
import 'package:log/Screens/SceltaVerificaAccount.dart';

//IN QUESA PAGINA INIZIALIZZO FIREBASE E MANTENGO SOTTO'OCCHIO LO STATO DELL'UTENTE, SE QUESTO E' LOGGATO GLI MOSTRO LA HOME
//SE NON LO E' PIU' PERCHE' HA CANCELLATO L'ACCOUNT HO HA FATTO SIGN OUT ALLORA GLI MOSTRO LA PAGINA DI REGISTRAZIONE

class RootPage extends StatelessWidget {
  static const id = "RootPage";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Quando un utente apre l'app controllo lo stato, se è loggato lo mando nella home altrimenti lo mando nella pagina registrazione
      future: firsUserStatus(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Caricamento Stato Utente..."),
            ),
            body: null,
          );
        } else if (snapshot.data != null) {
          if (snapshot.data.emailVerified == false) {
            print("UTENTE CON ACCOUNT NON VERIFICATO, CANCELLO ACCOUNT");
            snapshot.data.delete();
            return RegistrationPage();
          } else {
            print("UTENTE LOGGATO");
            return Home();
          }
        } else {
          print("UTENTE NON LOGGATO O SENZA ACCOUNT");
          return RegistrationPage();
        }
      },
    );
  }

  //INIZIALIZZO APP E CONTROLLO LO STATO
  Future<User> firsUserStatus() async {
    //inizializzo applicazione
    try {
      await Firebase.initializeApp();
      print("INIZIALIZZAZIONE APP");
    } catch (e) {
      print("FALLIMENTO INIZIALIZZAZIONE APP");
      return null;
    }
    return await userStatus();
  }

  //CONTROLLO STATO UTENTE
  Future<User> userStatus() async {
    //Stream restituisce "User" se l'utente è loggato e "Null" se non lo è o se non ha un account
    Stream stream = FirebaseAuth.instance.authStateChanges();
    User primoEvento = await stream.first;
    return primoEvento;
  }
}








/* FutureBuilder(
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
            //Mi metto in ascolto dello stato dell'utente. Quando questo cambia il suo stato cambio la pagina in cui si trova
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot1) {
              //Se l'utente non ha un account:
              if (snapshot1.data == null) {
                print("UTENTE NON LOGGATO O SENZA ACCOUNT");
                return RegistrationPage();
                //Nel caso un utente abbia un account:
              } else {
                //Se l'utente ha un account ma non è verificato allora gli cancello l'account e gliene faccio creare un'altro.
                if (snapshot1.data.emailVerified == false) {
                  print("ACCOUNT UTENTE ELIMINATO PERCHE' NON VERIFICATO");
                  snapshot1.data.delete();
                  return RegistrationPage();
                } else {
                  print("UTENTE LOGGATO");
                  return Home();
                }
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
    ); */