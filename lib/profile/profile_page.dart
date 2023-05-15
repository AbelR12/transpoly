import 'package:flutter/material.dart';
import 'package:transpoly/register/RegisterPage.dart';
class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 16.0, right: 16.0),
                  child: Text(
                    'Mon Profile',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
            Container(
              child: Expanded(
                child:Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Text(
                              ' Mes Informations',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0),
                            ),
                          ),
                          Icon(Icons.account_circle),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Card(
                        child: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('Nom et Prenoms'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'prenom.nom@inphb.ci'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('07 - 05 - 1993'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffffac30)),
                                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide.none,
                                        )),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Modifier',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        size: 16.0,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage()));

                        },

                        style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Couleur de fond rouge
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                        ),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.power_settings_new), // Icône de déconnexion
                        SizedBox(width: 8.0), // Espacement entre l'icône et le texte
                        Text('Se déconnecter'),
                        ],
                        ),
                        )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }}