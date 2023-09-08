import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:transpoly/main.dart';
import '../model/users.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  EditProfilePage({required this.user});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _matriculeController;
  late TextEditingController _mdpController;
  late TextEditingController _dateNaissanceController;
  late TextEditingController _telephoneController;

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

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.user.nom);
    _prenomController = TextEditingController(text: widget.user.prenom);
    _matriculeController = TextEditingController(text: widget.user.matricule);
    _mdpController = TextEditingController(text: widget.user.mdp);
    _dateNaissanceController = TextEditingController(text: widget.user.date_naissance);
    _telephoneController = TextEditingController(text: widget.user.telephone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Informations'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextFormField(
                controller: _matriculeController,
                decoration: InputDecoration(labelText: 'matricule'),
              ),
              TextFormField(
                controller: _dateNaissanceController,
                decoration: InputDecoration(labelText: 'date de naissance'),
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context);
                },
              ),
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(labelText: 'Téléphone'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Enregistrer les modifications et revenir à la page de profil
                  postDetailsToFirestore();
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),);
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nom = _nomController.text;
    userModel.prenom = _prenomController.text;
    userModel.date_naissance = _dateNaissanceController.text;
    userModel.matricule = _matriculeController.text;
    userModel.telephone = _telephoneController.text;
    userModel.mdp = _mdpController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update(userModel.toMap()); // Utilisez .update() au lieu de .set() pour mettre à jour les données existantes
    Fluttertoast.showToast(msg: "Modifications enregistrées avec succès :) ");
  }


}
