import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../model/profile.dart';
import 'package:flutter/material.dart';
import 'connection_interest_view.dart';

class WelcomeInterest extends StatelessWidget {
  Profile profile;
  IdealPerson idealPerson;
  WelcomeInterest({this.profile, this.idealPerson});
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
                Image.asset(
                  "assets/images/app_bar_2.png",
                ),
                Padding(
                  padding: EdgeInsets.only(top: _height * 0.04),
                  child: MaterialButton(
                      child: Text(
                        "<",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w800,
                          fontSize: 33,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
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
                            fontSize: 27),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            AutoSizeText(
              "Who are you looking for?",
              style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            AutoSizeText(
              "To see the right people, tell us who\nyou're into",
              style: TextStyle(fontSize: 19, fontFamily: 'Quicksand'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Image.asset("assets/images/interest_image.png"),
            SizedBox(
              height: _height * 0.03,
            ),
            Container(
              width: _width * 0.7,
              height: _height * 0.07,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: primaryColor)),
                  color: primaryColor,
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ConnectionInterest(
                                profile: profile,
                                idealPerson: idealPerson,
                              )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
