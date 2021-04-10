import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/LoginPage.dart';
import 'package:log/Screens/SceltaVerificaAccount.dart';
import 'package:log/Services/Auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:log/Services/FacebookAuth.dart';
import 'package:log/Services/GoogleAuth.dart';

//TODO: se la password inserita è troppo debole firebase la rifiuta, stessa cosa se l'email non ha il formato giusto, devo destire questi casi facendolo notare all utente
//TODO: controllare che l'account email esista al momento della registrazione, altrimenti non sono in grado di inviargli una email per la verifica
//test
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
                //REGISTRAZIONE/LOGIN CON SOCIAL

                //REGISTRAZIONE CON GOOGLE
                GoogleAuth(),

                //REGISTRAZIONE CON FACEBOOK
                FacebookAuth1(),

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
                            Navigator.pushNamed(
                                context, SceltaVerificaAccount.id, arguments: [
                              _emailController.text,
                              _passwordController.text
                            ]);
                          }
                        : null,
                    child: Text("Registrati!"),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Home.id);
                    },
                    child: Text("Continua Senza account"),
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
