import 'dart:async';
import 'package:flutter/material.dart';
import 'package:transpoly/fpassword/Rpassword.dart';

class Otp extends StatefulWidget {

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController _otp1 = TextEditingController();
  TextEditingController _otp2 = TextEditingController();
  TextEditingController _otp3 = TextEditingController();
  TextEditingController _otp4 = TextEditingController();
  int _remainingTime = 60;

  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "entrer le code OTP ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Temps restant : $_remainingTime secondes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: TextField(
                              controller: _otp1,
                              autofocus: true,
                              onChanged: (value) {
                                if (value.length == 1  ) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if (value.length == 0  ) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Color(0xffffac30)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: TextField(
                              controller: _otp2,
                              autofocus: true,
                              onChanged: (value) {
                                if (value.length == 1  ) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if (value.length == 0  ) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Color(0xffffac30)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: TextField(
                              controller: _otp3,
                              autofocus: true,
                              onChanged: (value) {
                                if (value.length == 1  ) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if (value.length == 0  ) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Color(0xffffac30)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: TextField(
                              controller: _otp4,
                              autofocus: true,
                              onChanged: (value) {
                                if (value.length == 1  ) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if (value.length == 0  ) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2, color: Color(0xffffac30)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResetPassword()));
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xffffac30)),
                          shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verifier',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Vous n'avez pas réçu de code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                    _otp1.clear();
                    _otp2.clear();
                    _otp3.clear();
                    _otp4.clear();
                    _remainingTime = 60;

                },
                child: GestureDetector(
                  child:Text(
                    " Renvoyer un nouveau code \n",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffac30),
                    ),
                    textAlign: TextAlign.center,
                  ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}