import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transpoly/register/RegisterPage.dart';

import '../model/users.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      this.loggedInUser = UserModel.fromMap(userDataSnapshot.data());
    } catch (error) {
      print("Error fetching user data: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Expanded(
                child: Text(
                  'Mon Historique',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
              ),
            ),

            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Mes Informations',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InfoRow(title: 'Nom et prénom', value: '${loggedInUser.nom} ${loggedInUser.prenom}'),
                    InfoRow(title: 'Email', value: '${loggedInUser.email}'),
                    InfoRow(title: 'Matricule', value: '${loggedInUser.matricule}'),
                    InfoRow(title: 'Téléphone', value: '${loggedInUser.telephone}'),
                    InfoRow(title: 'Date de naissance', value: '${loggedInUser.date_naissance}'),
                    SizedBox(height: 20.0),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(user: loggedInUser),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Modifier'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.power_settings_new),
              label: Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
