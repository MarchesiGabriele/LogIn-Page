import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:log/Screens/Home.dart';
import 'package:log/Services/GoogleAuth.dart';

//Uso questo widget quando voglio avere il pulsante per il signIn con Google

class GoogleAuthButton extends StatelessWidget {
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
        text: "Sign In With Google",
        onPressed: () async {
          UserCredential user = await GoogleAuth().signInGoogle();
          if (user != null) {
            print("VERIFICA CON GOOGLE EFFETTUATA");
            Navigator.pushNamed(context, Home.id);
          } else {
            print("ERRORE VERIFICA CON GOOGLE");
          }
        },
        backgroundColor: Colors.red,
        image: Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7Orbk_hp4YopD2HHRn198vBdKgkvbqfVWYQ&usqp=CAU",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
