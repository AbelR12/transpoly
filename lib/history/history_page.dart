import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/history_transaction.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _selectedMonth = 'Tout';
  List<String> _months = ['Tout', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Expanded(
             child: Text(
                'Mon Historique',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 19.0),
                        child: Row(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: _selectedMonth,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedMonth = newValue!;
                                });
                              },
                              isDense: true,
                              items: _months.map((month) {
                                return DropdownMenuItem(
                                  child: Text(month),
                                  value: month,
                                );
                              }).toList(),
                              underline: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('histories') .orderBy('date_heure', descending: true) // Tri par date
                    .where('uid', isEqualTo: currentUser?.uid) // Ajoutez cette ligne pour filtrer par UID
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Une erreur s\'est produite : ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('Aucune transaction trouvée.');
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      HistoryModel historyModel = HistoryModel.fromMap(doc.data() as Map<String, dynamic>);

                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 110,
                        color: Colors.amberAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child:Text(
                              'Opérateur: ${historyModel.operateur}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ), ),

                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(child:Text(
                              'Montant: ${historyModel.montant}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(child:Text(
                              'Date et heure: ${historyModel.date_heure}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                      Expanded(child:Text(
                              'Statut: ${historyModel.status}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
