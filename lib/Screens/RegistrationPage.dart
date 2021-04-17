import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/LoginPage.dart';
import 'package:log/Screens/SceltaVerificaAccount.dart';
import 'package:log/Widgets/FacebookAuthButton.dart';
import 'package:log/Widgets/GoogleAuthButton.dart';

//TODO: se la password inserita è troppo debole firebase la rifiuta, stessa cosa se l'email non ha il formato giusto, devo destire questi casi facendolo notare all utente
//TODO: controllare che l'account email esista al momento della registrazione, altrimenti non sono in grado di inviargli una email per la verifica
//test
//TODO: Usare Dispose quando ho finito di usare i texteditingcontrollers!
//TODO: usare una form per i campi di testo e il bottone di conferma

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

                //BOTTONE PER CONTINUARE SENZA ACCOUNT
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
