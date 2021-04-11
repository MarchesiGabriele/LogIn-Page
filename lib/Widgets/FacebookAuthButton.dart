import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/FacebookAuth1.dart';

class FacebookAuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: (MediaQuery.of(context).size.width - 300) / 4,
        top: 15,
      ),
      height: 40,
      width: 215,
      child: SignInButtonBuilder(
        text: "Sign In With Facebook",
        onPressed: () async {
          UserCredential user = await FacebookAuth1().signInFacebook();
          if (user != null) {
            print("ACCESSO CON FACEBOOK EFFETTUATO");
            Navigator.pushNamed(context, Home.id);
          } else {
            print("ERRORE NELL'ACCESSO CON FACEBOOK");
          }
        },
        backgroundColor: Colors.blue,
        image: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Facebook_logo_%28square%29.png/480px-Facebook_logo_%28square%29.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  } 
}