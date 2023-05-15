import 'package:flutter/material.dart';
import 'send_money_page.dart';

class SelectMoneyPage extends StatefulWidget {
  @override
  SelectMoneyPageState createState() => SelectMoneyPageState();
}

class SelectMoneyPageState extends State<SelectMoneyPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;

  List<MobileModel> receivers = [
    MobileModel('assets/images/om.png','Orange money','Transfert vers Orange money'),
    MobileModel('assets/images/mtn-momo.png','Mtn money','Transfert vers MTN money'),
    MobileModel('assets/images/moov-money.png','Moov money','Transfert vers Moov money'),
      MobileModel('assets/images/Wave.png','Wave money','Transfert vers Wave money'),
  ];

  List<MobileModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            _MobileMoneySection(),
            _MobileMoneyListSection()
          ],
        ),
      ),
    );
  }

  Widget _MobileMoneySection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTapUp: (tapDetail) {
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(

                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,

                        stops: [0.0, 0.5],
                        colors: [
                                Color(0xFFFFE369),
                                Color(0xffffac30)
                              ]
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.contact_phone,
                            color: selectedIndex == 0
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Mobile Money',
                                  style: TextStyle(
                                    fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
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
        ),
      ),
    );
  }

  Widget _MobileMoneyListSection() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Card(
              elevation: 4.0,
              child: SizedBox(
                height: 350.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchController.text.isEmpty ? receivers.length : searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _getReceiverSection(searchController.text.isEmpty ? receivers[index] : searchResults[index]);
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _getReceiverSection(MobileModel receiver) {
    return GestureDetector(
      onTapUp: (tapDetail) {
        Navigator.push(context,
            SendMoneyPageRoute(receiver));
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    receiver.logo,
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
                      receiver.text,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.mobile_screen_share_rounded,
                            size: 13.0,
                            color: Color(0xFF929091),),
                        ),
                        Text(
                          receiver.nom,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF929091)),
                        ),
                      ],
                    ),
                  ],
                )),
            Icon(Icons.chevron_right),

          ],
        ),
      ),
    );
  }
}
