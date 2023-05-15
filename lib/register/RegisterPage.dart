import 'package:flutter/material.dart';
import 'package:transpoly/login/SignIn.dart';
import 'package:transpoly/signup/SignUpPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sideImg.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                        Text("TransPoly", style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'ubuntu',
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 10,),
                        Text("Creer votre compte. \nTransfert instantanné.\nJoigner nous gratuitement", style: TextStyle(
                            color: Colors.grey
                        ),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: openSignInPage,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xffffac30),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Se connecter", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                          ),),
                          Icon(Icons.arrow_forward, size: 17,)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: openSignUpPage,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Creer votre compte ", style: TextStyle(
                              fontSize: 16
                          ),),
                          Icon(Icons.account_box, size: 17,)
                        ],
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

  void openSignInPage()
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignIn()));
  }
  void openSignUpPage()
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
  }
}