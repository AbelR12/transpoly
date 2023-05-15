import 'package:flutter/material.dart';
import 'package:transpoly/main.dart';

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
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
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
  final TextEditingController amountController = TextEditingController();
  final TextEditingController NumberController = TextEditingController();

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
                padding:
                    const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      "Envoyer de l'argent",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _getSection(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _getReceiverSection(widget.mobilemoney);
      case 1:
        return _EnterMoneySection();
      case 2:
        return _EnterNumberSection();
      case 3:
        return _NumberDebitSection();
      default:
        return _SendSection();
    }
  }
  Widget _getReceiverSection(MobileModel mobilemoney) {
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
          ))
        ],
      ),
    );
  }
  Widget _EnterMoneySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'entrer le montant',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
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
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: '0',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0)),
                          onChanged: (value) {
                            setState(() {

                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      'fcfa',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Text(
                  'Frais d\'opération: ${amountController.text.isNotEmpty ? (int.parse(amountController.text) * 0.01) : '0.0'} fcfa',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Text(
                  'Montant total à payer: ${amountController.text.isNotEmpty ? (int.parse(amountController.text) * 0.01 + int.parse(amountController.text)) : '0.0'} fcfa',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _EnterNumberSection() {
    return Container(
      height: 122,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'numero du destinataire',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: NumberController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          decoration: InputDecoration(
                            hintText: '',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0),
                            border: InputBorder.none, // supprime la ligne du bas
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _NumberDebitSection() {
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Numéro a débiter',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _getBankCard(index);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(index % 2 == 0
              ? 'assets/images/ico_logo_red.png'
              : 'assets/images/ico_logo_blue.png'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('0574829898'),
          )),
          Radio(
            activeColor: Color(0xFF65D5E3),
            value: index,
            groupValue: selectedCardIndex,
            onChanged: (int? value) {
              if (value != null) {
                selectedCardIndex = value;
                setState(() {});
              }
            },
          )
        ],
      ),
    );
  }

  Widget _SendSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTapUp: (tapDetail) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
              color: Color(0xffffac30),
              borderRadius: BorderRadius.all(Radius.circular(11.0))),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'ENVOYER',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
class MobileModel {
  final String logo;
  final String nom;
  final String text;

  MobileModel(
      this.logo, this.nom, this.text
      );

}
