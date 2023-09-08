import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:transpoly/login/LoginPage.dart';
import 'package:transpoly/main.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUp> {
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _dateNaissanceController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
//firebase

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _matriculeController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _dateNaissanceController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _mdp1Controller = TextEditingController();
  TextEditingController _mdp2Controller = TextEditingController();
  bool _isPasswordMatched = false;

  @override
  Widget build(BuildContext context) {
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
                          TextFormField(
                            controller: _matriculeController,
                            decoration: InputDecoration(
                              labelText: "Matricule",
                            ),
                            validator: (value) {
                              final RegExp regex = RegExp(r'^\d{2}INP\d{4}$');
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre matricule';
                              } else if (!regex.hasMatch(value)) {
                                return 'Le format du matricule est incorrect';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _nomController,
                            decoration: InputDecoration(
                              labelText: "Nom",
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre nom';
                              }
                              if (value![0] != value[0].toUpperCase()) {
                                return 'La première lettre doit être en majuscule';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _prenomController,
                            decoration: InputDecoration(
                              labelText: "Prénom",
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre prénom';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            controller: _dateNaissanceController,
                            decoration: InputDecoration(
                              labelText: "Date de naissance",
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre date de naissance';
                              }
                              return null;
                            },
                          ),                          TextFormField(
                            controller: _mailController,
                            decoration: InputDecoration(
                              labelText: "Mail institutionnel",
                            ),
                            validator: (value) {
                              final RegExp regex = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+@inphb\.ci$');
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse mail';
                              } else if (!regex.hasMatch(value)) {
                                return 'Le format du mail est incorrect';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _telephoneController,
                            decoration: InputDecoration(
                              labelText: "Numéro de téléphone",
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 10, // Ajouter la propriété maxLength pour limiter le nombre de chiffres
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre numéro de téléphone';
                              }
                              if (value!.length != 10) { // Ajouter une validation supplémentaire
                                return 'Le numéro de téléphone doit contenir 10 chiffres';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _mdp1Controller,
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 6,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre mdp';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _mdp2Controller,
                            decoration: InputDecoration(
                              hintText: "confirmer le mot de passe",
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 6,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              if (value != _mdp1Controller.text) {
                                _isPasswordMatched = false;
                                return 'Les mots de passe ne correspondent pas';
                              } else {
                                _isPasswordMatched = true;
                                return null;
                              }
                            },
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffffac30)),
                                ),
                                onPressed: () {
                                  signUp(_mailController.text, _mdp1Controller.text);
                                },
                                child: Text('Creer'),
                              ),
                              SizedBox(width: 20), // ajout d'un espacement entre les boutons
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Ajout d'un bouton retour
                                },
                                child: Text('Retour'),
                              ),
                            ],
                          ),

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
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
        }            errorMessage = "erreur lors de la connexion.";
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {


    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nom = _nomController.text;
    userModel.prenom = _prenomController.text;
    userModel.date_naissance=_dateNaissanceController.text;
    userModel.matricule=_matriculeController.text;
    userModel.telephone=_telephoneController.text;
    userModel.mdp=_mdp1Controller.text;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte creer avec succès :) ");

    Navigator.pushAndRemoveUntil(
        (context),
          MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
  }
  /*postDetailsToRealTimeDatabase() async {
    //DatabaseReference datapoly = FirebaseDatabase.instance.ref();
    CollectionReference colref = FirebaseFirestore.instance.collection("users");
    User? user = _auth.currentUser;

    colref.add({
      'uid': user!.uid,
      'nom': _nomController,
      'prenom': _prenomController,
      'email': _mailController.text,
      'matricule':_matriculeController.text,
      'date de naissance': _dateNaissanceController.text,
      'telephone':_telephoneController.text,
    });
    Fluttertoast.showToast(msg: "Compte creer avec success :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);


    //UserModel userModel = UserModel();

    // writing all the values
    /*userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nom = _nomController.text;
    userModel.prenom = _prenomController.text;
    userModel.date_naissance=_dateNaissanceController.text;
    userModel.matricule=_matriculeController.text;
    userModel.telephone=_telephoneController.text;*/

    /*datapoly
        .child("users")
        .push()
        .set(userModel.toMap()).then((value){
      Fluttertoast.showToast(msg: "Compte creer avec success :) ");
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => false);
    });*/

  }*/
}
