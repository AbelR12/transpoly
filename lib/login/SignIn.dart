import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transpoly/home/homepage.dart';
import 'package:transpoly/login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}


class _SignInPageState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _mdp1Controller = TextEditingController();
//firebase
  final _auth = FirebaseAuth.instance;
  String? errorMessage;


  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: _mailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          _mailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: _mdp1Controller,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("mot de passe requis pour se connecter");
          }
          if (!regex.hasMatch(value)) {
            return ("Entrer un mot de passe valide");
          }
        },
        onSaved: (value) {
          _mdp1Controller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mot de passe",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:(Color(0xffffac30)),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(_mailController.text, _mdp1Controller.text);
          },
          child: Text(
            "Se connecter",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sideImg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "TransPoly",
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'ubuntu',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          emailField,
                          SizedBox(height: 10),
                          passwordField,
                          SizedBox(height: 10),
                          loginButton,
                        ], // Added closing bracket for the Column widget
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
            email: _mailController.text, password: _mdp1Controller.text)
            .then((userCredential) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);

          Fluttertoast.showToast(msg: "Connexion réussie");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePage()));
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Votre adresse e-mail semble être malformée.";

            break;
          case "wrong-password":
            errorMessage = "votre mot de passe est incorrect.";
            break;
          case "user-not-found":
            errorMessage = "Utilisateur inexistant.";
            break;
          case "user-disabled":
            errorMessage = "L'utilisateur avec cette adresse e-mail a été désactivé.";
            break;
          case "too-many-requests":
            errorMessage = "Trop de demandes";
            break;
          case "operation-not-allowed":
            errorMessage = "La connexion avec e-mail et mot de passe n'est pas activée.";
            break;
          default:
            errorMessage = "Une erreur indéfinie s'est produite.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}

