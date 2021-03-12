import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/Auth.dart';

//NB: la pagina di registrazione e quella di login sono molto simili, cercare di creare o una classe astratta che ne fa da struttura o altro

class LoginPage extends StatefulWidget {
  static final String id = "LoginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  bool _validEmail;
  TextEditingController _passwordController;
  bool _validPassword;
  String _loginError;

  @override
  void initState() {
    super.initState();
    _loginError = "";
    _validEmail = false;
    _validPassword = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          //con autovalidate permetto ai campi di testo di aggiornarsi in tempo reale
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //messaggi di errore
              Text(_loginError),
              //CAMPO DI TESTO EMAIL
              TextFormField(
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

              //CAMPO DI TESTO PASSWORD
              TextFormField(
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

              //BOTTONE DI CONFERMA
              ElevatedButton(
                onPressed: _validEmail && _validPassword
                    ? () async {
                        //controllo che l'account esista, se esiste allora mando alla pagina principale altrimenti mostro un errore
                        String result = await Auth().loginWithEmail(
                            _emailController.text, _passwordController.text);
                        print("cavallo");
                        if (result == "No user found for that email") {
                          setState(() {
                            _loginError = result;
                          });
                        } else if (result ==
                            "Wrong password provided for that user") {
                          setState(() {
                            _loginError = result;
                          });
                        } else if (result == "ok") {
                          Navigator.pushNamed(context, Home.id);
                        } else {
                          print(result);
                        }
                      }
                    : null,
                child: Text("Login!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
