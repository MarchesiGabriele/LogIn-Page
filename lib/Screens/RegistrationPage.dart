import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Screens/LoginPage.dart';
import 'package:log/Services/Auth.dart';
import 'PaginaVerificaEmail.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

//TODO: se la password inserita è troppo debole firebase la rifiuta, stessa cosa se l'email non ha il formato giusto, devo destire questi casi facendolo notare all utente
//TODO: controllare che l'account email esista al momento della registrazione, altrimenti non sono in grado di inviargli una email per la verifica
//test

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
          centerTitle: true,
          title: Text(_title),
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
        body: Form(
          //con autovalidate permetto ai campi di testo di aggiornarsi in tempo reale
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              //REGISTRAZIONE/LOGIN CON SOCIAL

              //REGISTRAZIONE CON GOOGLE
              Container(
                margin: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width - 215) / 2,
                    top: 15),
                height: 40,
                width: 215,
                child: SignInButtonBuilder(
                  text: "Sign In With Google",
                  onPressed: () async {
                    UserCredential user = await Auth().signInGoogle();
                    if (user != null)
                      Navigator.pushNamed(context, Home.id);
                    //eseguo qualcosa in caso la registrazione vada storta
                    else {}
                  },
                  backgroundColor: Colors.red,
                  image: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7Orbk_hp4YopD2HHRn198vBdKgkvbqfVWYQ&usqp=CAU",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //REGISTRAZIONE CON FACEBOOK
              Container(
                margin: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width - 215) / 2,
                    top: 15),
                height: 40,
                width: 215,
                child: SignInButtonBuilder(
                  text: "Sign In With Facebook",
                  onPressed: () async {
                    UserCredential user = await Auth().signInWithFacebook();
                    if (user != null)
                      Navigator.pushNamed(context, Home.id);
                    //eseguo qualcosa in caso la registrazione vada storta
                    else {}
                  },
                  backgroundColor: Colors.blue,
                  icon: Icons.ac_unit,
                ),
              ),

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
                          UserCredential p = await Auth().registrazioneEmail(
                              _emailController.text, _passwordController.text);
                          print(p.user.email);
                          //invio email conferma
                          await Auth().emailVerification();
                          Navigator.pushNamed(context, PaginaVerificaEmail.id,
                              arguments: p);
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
    );
  }
}
