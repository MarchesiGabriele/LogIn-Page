import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/Auth.dart';

class RegistrationPage extends StatefulWidget {
  static String id = "RegistrationPage";
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  static const String _title = "Registration Page";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _validEmail = false;
  bool _validPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Form(
          //con autovalidate permetto ai campi di testo di aggiornarsi in tempo reale
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
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
                        UserCredential p = await Auth().registrazioneEmail(
                            _emailController.text, _passwordController.text);
                        print(p.user.email);
                        Navigator.pushNamed(context, Home.id);
                      }
                    : null,
                child: Text("Registrati!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
