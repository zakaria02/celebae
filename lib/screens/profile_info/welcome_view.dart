import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WelcomeProfile extends StatelessWidget {
  final Color primaryColor = Color(0xFFff0e55);
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset("assets/images/app_bar_2.png"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: _height * 0.05),
                      child: Text(
                        "Celebae",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.1,
            ),
            Image.asset("assets/images/man_sitting.png"),
            SizedBox(
              height: _height * 0.1,
            ),
            AutoSizeText(
              "Let's start with the basics",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              "Set up your profile to meet new people",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Quicksand',
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: _height * 0.1,
            ),
            Container(
              width: _width * 0.7,
              height: _height * 0.08,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: primaryColor)),
                  color: primaryColor,
                  child: Text(
                    "START",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/userGender');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
