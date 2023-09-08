import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transpoly/fpassword/FpasswordPage.dart';
import 'package:transpoly/main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:transpoly/model/users.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

List<int> firt=[1,2,3], second=[4,5,6], third=[7,8,9];
class _LoginPageState extends State<LoginPage> {
  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String title ="Entrer votre mot de passe";
  int mdplength=6;
  String mdpenter="";
  String vorf="";
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  String _authorized = 'Non autorisé';
  bool _isAuthenticating = false;
  Future<void> fetchUserData() async {
    try {
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      this.loggedInUser = UserModel.fromMap(userDataSnapshot.data());
    } catch (error) {
      print("Error fetching user data: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // Vérifier si le périphérique prend en charge l'authentification biométrique
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }



  Future<void> _authenticateWithBiometrics() async {
    // Authentification uniquement avec la biométrie
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authentification';
      });
      authenticated = await auth.authenticate(
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ), localizedReason: 'Valider votre authentification',
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authentification';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Erreur - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Autorisé' : 'Non Autorisé';
    setState(() {
      _authorized = message;
    });

    // Naviguer vers MyHomePage si l'authentification réussit
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }


  numberClic(int item) {
    // Ajouter le chiffre sélectionné à la variable mdpenter
    if (mdpenter.length < 6) {  // Vérifier si la longueur est inférieure à 4
      mdpenter += item.toString();  // Ajouter le chiffre à la variable mdpenter
    }
    // Vérifier si la longueur de mdpenter correspond à la longueur du mot de passe
    if (mdpenter.length == mdplength) {
      // Vérifier si mdpenter correspond au mot de passe correct
      if (mdpenter == loggedInUser.mdp) {
        // Actions à effectuer lorsque le mot de passe est correct
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );

      } else {
        // Actions à effectuer lorsque le mot de passe est incorrect
        vorf = 'mot de passe incorrect';

        setState(() {
          // Mettre à jour l'icône en fonction de la correspondance entre mdpenter et mdpcorrect
          loggedInUser.mdp == mdpenter ? Icons.circle : Icons.circle_outlined;
          print({loggedInUser.nom});
          print({loggedInUser.mdp});
          print({mdpenter});
          // Réinitialiser mdpenter à une chaîne vide
          mdpenter = "";
        });
      }
    }

    setState(() {});
  }
  back() {
    if (mdpenter.length > 0)
      // Supprimer le dernier caractère de mdpenter
      mdpenter = mdpenter.substring(0, mdpenter.length - 1);

    // Réinitialiser la variable vorf à une chaîne vide
    vorf = "";

    setState(() {});
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kToolbarHeight-10,),
          Image.asset('assets/images/logo.png',height: 70,width: 70,),
          Text(title,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon( (mdpenter.length>=1)? Icons.circle: Icons.circle_outlined),),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon((mdpenter.length>=2)? Icons.circle: Icons.circle_outlined),),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon((mdpenter.length>=3)? Icons.circle:Icons.circle_outlined),),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon((mdpenter.length>=4)? Icons.circle: Icons.circle_outlined),),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon((mdpenter.length>=5)? Icons.circle: Icons.circle_outlined),),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child:Icon((mdpenter.length==6)? Icons.circle: Icons.circle_outlined),),
              ],
            ),
          ),
          Text(
            vorf,
            style: TextStyle(
                color: (mdpenter==loggedInUser.mdp)?Colors.green:Colors.red
            ),
          ),
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            );
          }, child: Text(
              'mot de passe oublié ?'
          )),
          Expanded(
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: firt.map((e) => numberButton(e)).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: second.map((e) => numberButton(e)).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: third.map((e) => numberButton(e)).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _authenticateWithBiometrics,
                        icon: Icon(Icons.fingerprint_outlined),
                      ),
                      numberButton(0),
                      IconButton(onPressed: ()=> back(), icon:Icon(Icons.backspace_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget numberButton(int item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: InkResponse(
        onTap: () => numberClic(item), // Appeler la fonction numberClic lorsque le bouton est cliqué
        child: Ink(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: Color(0xffffac30),
                width: 2.0,
              ),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => numberClic(item), // Appeler la fonction numberClic lorsque le bouton est cliqué
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                item.toString(), // Afficher le chiffre du bouton
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
enum _SupportState {
  unknown,     // État inconnu du support
  supported,   // Supporté
  unsupported, // Non supporté
}

