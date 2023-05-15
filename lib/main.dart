import 'package:flutter/material.dart';
import 'package:transpoly/history/history_page.dart';
import 'package:transpoly/home/homepage.dart';
import 'package:transpoly/profile/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transpoly/splash_screen/SplashScreen.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TransPoly',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: new SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:  Color(0xffffac30), // couleur des labels sélectionnés
          unselectedLabelStyle: TextStyle(color: Colors.grey), // couleur des labels non sélectionnés
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _curIndex,
          onTap: (index) {
            _curIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon:  SvgPicture.asset('assets/home-icon.svg'),
              activeIcon: SvgPicture.asset('assets/home-icon-yellow.svg'),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon:  SvgPicture.asset('assets/transactions-icon.svg'),
              activeIcon : SvgPicture.asset('assets/transactions-icon-yellow.svg'),
              label: 'Historiques',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/smiley-icon.svg'),
              activeIcon : SvgPicture.asset('assets/smiley-icon-yellow.svg'),
              label: 'Compte',
            ),
          ]
      ),

    body: new Center(
        child: _getWidget(),
      ),
    );

  }

  Widget _getWidget() {
    switch (_curIndex) {
      case 0:
        return Container(
          color: Colors.red,
          child: HomePage(),
        );
      case 1:
        return Container(
          child: HistoryPage(),
        );
      case 2:
        return Container(
          child: ProfilePage(),
        );
      default:
        return Container(
          child: HomePage(),
        );
    }
  }
}
