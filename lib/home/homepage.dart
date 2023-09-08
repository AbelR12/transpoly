import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transpoly/send_money/select_account_page.dart';
import '../send_money/StatusPage.dart';
import 'cards.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double screenWidth = 0.0;
  List<String> names = ['Aka', 'Lembe', 'Diomandé', 'Kacou',"N'dri",'Kouakou','Zeba'];

  late DocumentReference transactionDocRef; // Declare the variable

  @override
  void initState() {
    super.initState();
    // Initialize transactionDocRef here
    transactionDocRef = FirebaseFirestore.instance.collection('histories').doc('uid');

  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return accueil();
            } else if (index == 1) {
              return envoiArgent();
            } else {
              return _envoiContact();
            }
          }),
    );
  }

  Widget accueil()
  {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     children: [
                       Container(
                         height: 30,
                         width: 30,
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: AssetImage('assets/images/logo.png'),
                                 fit: BoxFit.contain
                             )
                         ),
                       ),
                       Text(
                         'TransPoly',
                         style: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                     ],
                   )
                  ],
                ),
                Stack(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionStatusPage(
                                status: 'Transaction en cours',
                                message: 'Veuillez patienter, votre transaction est en cours de traitement',
                                transactionDocRef: transactionDocRef,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.notifications_none,
                          size: 30.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(
                          Icons.notifications_none,
                          size: 30.0,
                        ),
                      ),
                      new Positioned(  // draw a red marble
                        top: 3.0,
                        left: 3.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFE95482),
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              '02',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 8.0),
                  child:Text(
                    'Accueil',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                CardsList(),
              ],
            ),
          ],
        )
      ),
    );
  }
  Widget envoiArgent() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
//      height: 400.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text("Transfert d'argent")),
          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    onTapUp: (tapDetail) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectMoneyPage(),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset('assets/images/ico_send_money.png'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Envoyer de \n   l'argent",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _envoiContact() {
    var smallItemPadding = EdgeInsets.only(
        left: 12.0, right: 12.0, top: 12.0);
    if (screenWidth <= 320) {
      smallItemPadding = EdgeInsets.only(
          left: 10.0, right: 10.0, top: 12.0);
    }
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Envoyer a un contact",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 100.0,
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Padding(
                      padding: smallItemPadding,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/ico_add_new.png',
                            height: 40.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Ajouter'),
                          )
                        ],
                      ),
                    ),
                    for (String name in names)
                      Padding(
                      padding: smallItemPadding,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            child: Text(
                              name.substring(0,1),
                              style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(name),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
