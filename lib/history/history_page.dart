import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> histories = [
    HistoryModel('assets/images/ico_send_money.png', 'Envoyer\na', 'Dohou Abraham', 9990,
        '01 Février 2023', 'assets/images/ico_logo_red.png'),
    HistoryModel('assets/images/ico_send_money.png', 'Envoyer\na',
        'Appia Felix', 8300, '08 Mars 2023', 'assets/images/ico_logo_red.png'),
    HistoryModel('assets/images/ico_send_money.png', 'Envoyer\na',
        'Aka Hans', 8300, '15 Avril 2023', 'assets/images/ico_logo_blue.png'),
    HistoryModel('assets/images/ico_send_money.png', 'Envoyer\na', 'Aka Messou',
        3000, '22 Mai 2023', 'assets/images/ico_logo_blue.png'),
  ];
  String _selectedMonth='Tout';

  List<String> _months = ['Tout',  'Janvier',  'Février',  'Mars',  'Avril',  'Mai',  'Juin',  'Juillet',  'Août',  'Septembre',  'Octobre',  'Novembre',  'Décembre'];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Text(
                'Mon Historique',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
//              height: 42.0,
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
                      underline: Container(), // Enlève la ligne en dessous du bouton
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
              child: ListView.builder(
                  itemCount: histories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _historyWidget(histories[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyWidget(HistoryModel history) {
    return Container(
//      height: 100.0,
    margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  history.historyAssetPath,
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        history.historyType,
                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                      ),
                      Text(history.receiverName)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${history.amount} fcfa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${history.date}\n',
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Image.asset(
                              history.cardLogoPath,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryModel {
  final String historyAssetPath;
  final String historyType;
  final String receiverName;
  final double amount;
  final String date;
  final String cardLogoPath;

  HistoryModel(this.historyAssetPath, this.historyType, this.receiverName,
      this.amount, this.date, this.cardLogoPath);
}
