import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/LoginPage.dart';
import 'package:log/Screens/SceltaVerificaAccount.dart';
import 'package:log/Widgets/FacebookAuthButton.dart';
import 'package:log/Widgets/GoogleAuthButton.dart';

//IN QUESTA PAGINA L'UTENTE PUO' REGISTRARSI CON EMAIL E PASSWORD O USANDO I SOCIAL

//TODO: Usare Dispose quando ho finito di usare i texteditingcontrollers!

class RegistrationPage extends StatefulWidget {
  static const String id = "RegistrationPage";
  final String _title = "Registration Page";
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _validEmail = false;
  bool _validPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget._title),
          leading: Container(),
          actions: [
            //Pulsante per accedere alla pagina di login
            Container(
              padding: EdgeInsets.only(right: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                child: Text("LogIn"),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            //con autovalidate permetto ai campi di testo di aggiornarsi in tempo reale
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //REGISTRAZIONE CON GOOGLE
                GoogleAuthButton(),

                //REGISTRAZIONE CON FACEBOOK
                FacebookAuthButton(),

                //CAMPO DI TESTO EMAIL
                Container(
                  padding: EdgeInsets.only(top: 150),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    controller: _emailController,
                    onChanged: (email) {
                      if (email.isEmpty) {
                        _validEmail = false;
                      } else {
                        _validEmail = true;
                      }
                    },
                    validator: (email) =>
                        email.isEmpty ? "Insert a Valid Email" : null,
                  ),
                ),

                //CAMPO DI TESTO PASSWORD
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    onChanged: (password) {
                      setState(() {
                        if (password.isEmpty) {
                          _validPassword = false;
                        } else {
                          _validPassword = true;
                        }
                      });
                    },
                    validator: (password) =>
                        password.isEmpty ? "Insert a Valid Password" : null,
                  ),
                ),

                //BOTTONE DI CONFERMA
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    //se email e password sono valide allora procedo alla registrazione
                    onPressed: _validEmail && _validPassword
                        ? () async {
                            //Vado alla pagina di scelta del metodo di verifica. Passo come parametri email e password.
                            Navigator.pushNamed(
                                context, SceltaVerificaAccount.id, arguments: [
                              _emailController.text,
                              _passwordController.text
                            ]);
                          }
                        : null,
                    child: const Text("Registrati!"),
                  ),
                ),

                //BOTTONE PER CONTINUARE SENZA ACCOUNT
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Home.id);
                    },
                    child: const Text("Continua Senza account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
