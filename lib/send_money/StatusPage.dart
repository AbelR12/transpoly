import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transpoly/main.dart';
import '../model/history_transaction.dart';

class TransactionStatusPage extends StatefulWidget {
  final String status;
  final String message;
  final DocumentReference transactionDocRef;

  TransactionStatusPage({required this.status, required this.message, required this.transactionDocRef});

  @override
  _TransactionStatusPageState createState() => _TransactionStatusPageState();
}

class _TransactionStatusPageState extends State<TransactionStatusPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  void initState() {
    super.initState();
    _startListeningToStatusChanges();
  }

  void _startListeningToStatusChanges() {
    widget.transactionDocRef.snapshots().listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String newStatus = snapshot.get("status");
        if (newStatus == "terminé") {
          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200,),
                Text(
                  'Status de la transaction',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('histories')
                        .where('uid', isEqualTo: currentUser?.uid)
                        .where('status', isEqualTo: 'en cours')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (isLoading && snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Une erreur s\'est produite : ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('Aucune transaction en cours.');
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];
                          HistoryModel historyModel = HistoryModel.fromMap(doc.data() as Map<String, dynamic>);

                          String displayText = historyModel.text ?? ''; // Utilisez un texte par défaut si historyModel.text est nul

                          return Text(
                            displayText,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false,
                    );
                  },
                  child: Text('Fermer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
