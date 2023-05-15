import 'package:flutter/material.dart';

import 'package:transpoly/login/LoginPage.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}


class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _mdp1Controller = TextEditingController();
  TextEditingController _mdp2Controller = TextEditingController();
  bool idem = false;

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
                            controller: _mdp1Controller,
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                            ),
                            autofocus: true,
                            onChanged: (value) {
                              if (value.length == 4  ) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (value.length == 0  ) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            showCursor: false,
                            readOnly: false,
                            keyboardType: TextInputType.phone,
                            maxLength: 4,
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
                            autofocus: true,
                            onChanged: (value) {
                              if (value.length == 4  ) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (value.length == 0  ) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            showCursor: false,
                            readOnly: false,
                            keyboardType: TextInputType.phone,
                            maxLength: 4,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              if (value != _mdp1Controller.text) {
                                idem = false;
                                return 'Les mots de passe ne correspondent pas';
                              } else {
                                idem = true;
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
                                  if (_formKey.currentState!.validate() && idem) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                                  }

                                },
                                child: Text('Valider'),
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
}
