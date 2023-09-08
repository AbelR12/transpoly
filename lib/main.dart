import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:transpoly/history/history_page.dart';
import 'package:transpoly/home/homepage.dart';
import 'package:transpoly/login/LoginPage.dart';
import 'package:transpoly/profile/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transpoly/register/RegisterPage.dart';
import 'package:transpoly/splash_screen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importez SharedPreferences

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCMToken $fcmToken");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    // Affichez le titre et le corps dans une interface utilisateur

    // Vous pouvez également déclencher des actions spécifiques en fonction de la notification reçue
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    runApp(MyApp()); // Utilisez le chemin que vous avez configuré pour la page de transactions
  });


  runApp( MyApp());
}

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
      home: FutureBuilder<bool>(
        future: checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (snapshot.data == true) {
              return LoginPage();
            } else {
              return RegisterPage(); // Utilisez LoginPage au lieu de RegisterPage
            }
          }
        },
      ),
    );
  }
}
Future<bool> checkIfLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
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
