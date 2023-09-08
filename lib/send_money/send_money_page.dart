import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:transpoly/main.dart';
import 'package:transpoly/model/history_transaction.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'StatusPage.dart';

class SendMoneyPageRoute extends PageRouteBuilder {
  SendMoneyPageRoute(MobileModel receiver)
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return SendMoneyPage(
        mobilemoney: receiver,
      );
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}

class SendMoneyPage extends StatefulWidget {
  final MobileModel mobilemoney;

  SendMoneyPage({required this.mobilemoney});

  @override
  SendMoneyPageState createState() => SendMoneyPageState();
}

class SendMoneyPageState extends State<SendMoneyPage> {
  String? userPhoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref().child('users');
  late String phoneNumber = '';
  final TextEditingController amountController = TextEditingController();
  final TextEditingController NumberController = TextEditingController();
  final TextEditingController mobilemoneyController = TextEditingController();
  final TextEditingController DebitController = TextEditingController();
  bool isTransactionInProgress = false;
  bool isNumberFieldEmpty = true;


  void initState() {
    super.initState();

    final User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users') // Remplacez par le nom de votre collection d'utilisateurs dans Firestore
          .doc(currentUser.uid) // Utilisez l'UID de l'utilisateur actuellement connecté
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final userData = documentSnapshot.data() as Map<String, dynamic>;
          final userPhoneNumber = userData['telephone'] as String?;

          if (userPhoneNumber != null && userPhoneNumber.isNotEmpty) {
            // Mettre à jour DebitController avec le numéro de téléphone de l'utilisateur
            DebitController.text = userPhoneNumber;
          }
        }
      });
    }
  }

  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    "Envoyer de l'argent",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return _getSection(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _debitNumber = '';
  String __debitNumber = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _getReceiverSection(widget.mobilemoney);
      case 1:
        return _EnterMoneySection();
      case 2:
        return _EnterNumberSection(widget.mobilemoney);
      case 3:
        return _auth.currentUser != null
            ? _NumberDebitSection()
            : Container(); // N'affiche rien si l'utilisateur n'est pas connecté

      default:
        return _SendSection();
    }
  }

  Widget _getReceiverSection(MobileModel mobilemoney) {
    mobilemoneyController.text = mobilemoney.nom;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                mobilemoney.logo,
                height: 45.0,
                width: 45.0,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  mobilemoney.nom,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _EnterMoneySection() {
    String errorMessage = '';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'entrer le montant',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                                ),
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onChanged: (value) {
                                  if (int.tryParse(value) != null && int.parse(value) >= 500) {
                                    setState(() {
                                      errorMessage = ''; // Clear the error message if the value is valid
                                    });
                                   } else {
                                    setState(() {
                                      errorMessage = "Tremo n'autorise que des transferts supérieurs ou égaux à 500";
                                      Fluttertoast.showToast(
                                        msg: errorMessage,
                                        backgroundColor: Colors.red, // Couleur d'arrière-plan du toast
                                        textColor: Colors.white, // Couleur du texte du toast
                                        gravity: ToastGravity.BOTTOM, // Position du toast
                                        toastLength: Toast.LENGTH_LONG, // Durée d'affichage du toast
                                      );
                                    });
                                  }
                                },
                              )

                      ),
                    ),
                    Text(
                      'fcfa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Text(
                  'Frais d\'opération: ${amountController.text.isNotEmpty ? (int.parse(amountController.text) * 0.02) : '0.0'} fcfa',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Text(
                  'Montant total à payer: ${amountController.text.isNotEmpty ? (int.parse(amountController.text) * 0.02 + int.parse(amountController.text)) : '0.0'} fcfa',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _EnterNumberSection(MobileModel mobilemoney) {
    String errorMessage = '';

    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'numero du destinataire',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Form(
                  key: _form,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                              controller: NumberController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                                border: InputBorder.none,
                                errorText: errorMessage.isNotEmpty ? errorMessage : null,
                              ),
                              validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champ est obligatoire';
                                  } else if (mobilemoney.nom == 'Orange money') {
                                  if (!value.startsWith('07')) {
                                      return "Le numéro doit commencer par '07'";
                                  } else if (value.length != 10) {
                                    return 'Le numéro doit contenir 10 chiffres';
                                  } else {
                                      errorMessage = '';
                                  }
                                }
                                else if (mobilemoney.nom == 'Mtn money') {
                                  if (!value.startsWith('05')) {
                                    return  "Le numéro doit commencer par '05'";
                                  } else if (value.length != 10) {
                                    return  'Le numéro doit contenir 10 chiffres';
                                  } else {
                                      errorMessage = '';
                                  }
                                }
                                else if (mobilemoney.nom == 'Moov money') {
                                  if (!value.startsWith('01')) {
                                    return  "Le numéro doit commencer par '01'";
                                  } else if (value.length != 10) {
                                    return  'Le numéro doit contenir 10 chiffres';
                                  } else {
                                    setState(() {
                                      errorMessage = '';
                                    });
                                  }
                                }
                                  else if (mobilemoney.nom == 'Wave money') {
                                    if (!value.startsWith('01')) {
                                      return  "Le numéro doit commencer par '01'";
                                    } else if (value.length != 10) {
                                      return  'Le numéro doit contenir 10 chiffres';
                                    } else {
                                      setState(() {
                                        errorMessage = '';
                                      });
                                    }
                                  }

                                else if (value.length != 10) {
                                    return  'Le numéro doit contenir 10 chiffres';
                                } else {
                                  setState(() {
                                    errorMessage = '';
                                  });
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  isNumberFieldEmpty = value.isEmpty;
                                  __debitNumber=value;
                                });}
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _NumberDebitSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Numéro Trémo à débiter',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/images/ico_logo_red.png'),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: DebitController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est obligatoire';
                              } else if (!value.startsWith('01') &&
                                  !value.startsWith('05') &&
                                  !value.startsWith('07')) {
                                return "Le numéro doit commencer par '01' ou '05' ou '07'";
                              } else if (value.length != 10) {
                                return 'Le numéro doit contenir 10 chiffres';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _debitNumber = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SendSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTapUp: isTransactionInProgress || isNumberFieldEmpty
            ? null
            : (tapDetail) async {
          // Vérifier si une transaction est en cours
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult != ConnectivityResult.none) {
            if (_formKey.currentState!.validate() && _form.currentState!.validate()) {
              if (await isTransactionInProgresss()) {
                // Une transaction est en cours, afficher un message d'erreur
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Transaction en cours"),
                      content: Text("Une transaction est déjà en cours. Veuillez patienter, s'il vous plaît."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              else {
                // Pas de transaction en cours, procéder à la nouvelle transaction
                if (_formKey.currentState!.validate() && _form.currentState!.validate()) {
                  SendSMS();
                  postDetailsToFirestore();
                }
              }
            }
          }
          else {
            // Pas de connexion Internet, afficher un message d'erreur
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Pas de connexion Internet"),
                  content: Text("Veuillez vérifier votre connexion Internet puis réessayer."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            color: isTransactionInProgress ? Colors.grey : Color(0xffffac30),
            borderRadius: BorderRadius.all(Radius.circular(11.0)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'ENVOYER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

// ...



  Future<bool> isTransactionInProgresss() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("histories").where("status", isEqualTo: "en cours").get();
    return querySnapshot.docs.isNotEmpty;

  }


  Future<void> sendNotifications() async {
    final String serverKey = 'AAAAcIPAflQ:APA91bF1_JT8oiLCsJvxmnKrSXnkbAUj81qGnEFWdMwuB9RNOOrFqNcHyhS1FMkGa1mbO1znm3k0FX_Fz7P75iEvBlF6_hh1bPz_cXTc99HZbJG32SHB3UoFR8FiwboZmHqz_8AMwsyK';
    final String url = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> data = {
      "priority":"high",
      "notification": {
        "title": "Nouvelle transaction",
        "body": "Une transaction vient d'être enclenchée."
      },
      "to": "e97m9h2kS42pjimiXWMM2i:APA91bHgzb59fF38WHzszooOwQxiDlZhfCTV7gdQiOxHTsnnSUD1W7rmAkd0I53jWKWNI49xiuCKm9ANPuD5BsZC7z2Zeg2EGZ0818FMf9rd1E7V0gdB-YYb6sWCnl2ihygym__YTZaw"
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      print('Notification envoyée avec succès');
    } else {
      print('Erreur lors de l\'envoi de la notification : ${response.statusCode}');
    }
  }
  void SendSMS() async{
    final String serverKey ='\$2a\$10\$LE/u/3ncYLw.NHtUwhGL9OfXrRWh11SQR/0OGz0ZI5Ak/3hPpmbim';
    String apiUrl = "https://sms.acim-ci.net:8443/api/addOneSms";
    String username = 'inphbApi';
    String token = "\$2a\$10\$LE/u/3ncYLw.NHtUwhGL9OfXrRWh11SQR/0OGz0ZI5Ak/3hPpmbim";
    String dest = '2250574827731';
    String sms = "Une transaction vient d'être enclenchée.";
    String flash = '0';
    String sender = 'ACIM INFO';
    String titre = 'TRANSPOLY';
    Map<String, dynamic> data = {
      'Username':username,
      'Token':token,
      'Dest':dest,
      'Sms':sms,
      'Flash':flash,
      'Sender':sender,
      'Titre':titre,
      };
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };


    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        print("SMS envoyé avec succès");
      } else {
        print('Echec de l\'envoi du SMS, code de l\'erreur : ${response.statusCode}');
      }
    } catch (error) {
      print("Error sending SMS: $error");
    }

  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? currentUser = FirebaseAuth.instance.currentUser;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(DateTime.now());
    // Envoyer un message avec des données personnalisées
    try {

      if (currentUser != null) {
        HistoryModel historyModel = HistoryModel();
        historyModel.uid = currentUser.uid;
        historyModel.operateur = mobilemoneyController.text;
        historyModel.date_heure = formattedDate;
        historyModel.num_destinataire = NumberController.text;
        historyModel.num_destinateur = DebitController.text;
        historyModel.montant = int.tryParse(amountController.text) ?? 0;
        historyModel.frais = (double.parse(amountController.text) * 0.02);
        historyModel.total =
        (double.parse(amountController.text) * 0.02 +
            double.parse(amountController.text));
        historyModel.status = "en cours";

        DocumentReference transactionDocRef =
        await firebaseFirestore.collection("histories").add(historyModel.toMap());
        await sendNotifications();
        if (isTransactionInProgress) {
          Fluttertoast.showToast(msg: 'Vous avez déjà initié une transaction. Veuillez patienter, s\'il vous plaît.');
          return;
        } else {
          Fluttertoast.showToast(msg: "Transaction en cours");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionStatusPage(
                status: "Transaction en cours",
                message: "Veuillez patienter, votre transaction est en cours de traitement.",
                transactionDocRef: transactionDocRef,
              ),
            ),
                (route) => false,
          );
        }

        setState(() {
          isTransactionInProgress = true;
        });

        mobilemoneyController.clear();
        NumberController.clear();
        DebitController.clear();
        amountController.clear();
      } else {
        Fluttertoast.showToast(msg: "Utilisateur non connecté");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Erreur lors de la transaction");
    } finally {
      setState(() {
        isTransactionInProgress = false;
      });
    }
  }
}

class MobileModel {
  final String logo;
  final String nom;
  final String text;

  MobileModel(this.logo, this.nom, this.text);
}
