import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transpoly/login/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then(
            (value)
        {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => LoginPage())
          );
        }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animations/money.json'),
                      const SizedBox(height: 100,),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.15,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              'Chargement...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}


