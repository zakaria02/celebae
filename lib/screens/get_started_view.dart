import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  double height = 0, width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final Color primaryColor = Color(0xFFff0e55);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset("assets/images/app_bar_1.png"),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                            child: Text(
                              "Sign In >",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signIn');
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Center(
              child: AutoSizeText(
                "You're about to go on a better dates !",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Image.asset("assets/images/couple.png"),
            SizedBox(
              height: height * 0.04,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "We go beneath the surface to show off \nthe real you."),
                      TextSpan(
                          text: " How's that for a change?",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: width * 0.7,
              height: height * 0.05,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: primaryColor)),
                  color: primaryColor,
                  child: Text(
                    "JOIN CELEBAE",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signUp');
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Quicksand',
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: "By Countinuing, you agree on our "),
              TextSpan(
                  text: "Terms.",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " Learn how we process\nyour data in our "),
              TextSpan(
                  text: "PRIVACY POLICY",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " and "),
              TextSpan(
                  text: "COOKIES POLICY.\n",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
