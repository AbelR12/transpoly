import 'package:flutter/material.dart';
import 'package:transpoly/fpassword/Vpassword.dart';


class ForgotPasswordPage extends StatelessWidget {
  TextEditingController tel = TextEditingController();


  TextStyle titleText = TextStyle(color: Color(0xffffac30), fontSize: 32, fontWeight: FontWeight.w700);
  TextStyle subTitle = TextStyle(
      color:  Color(0xFF59706F), fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle textButton = TextStyle(
    color: Color(0xffffac30),
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:30,),
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
              height: 100,
            ),
            Text(
              'Mot de passe oublié',
              style: titleText,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'entrez votre numéro de téléphone',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: tel,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '0102030405',
                  hintStyle: TextStyle(color:    Color(0xFF979797)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffac30)))),
            ),
          ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Otp(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), color: Color(0xffffac30)),
                  child: Text(
                    'Envoyer',
                    style: textButton.copyWith(color: Color(0xFFFFFFFF)),
                  ),
                ),
            ),],
        ),
      ),
    );
  }
}