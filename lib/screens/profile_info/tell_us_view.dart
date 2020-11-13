import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../model/profile.dart';
import 'package:flutter/material.dart';

import 'user_image.dart';

class TellUs extends StatelessWidget {
  Profile profile;
  IdealPerson idealPerson;
  TellUs({this.profile, this.idealPerson});
  final Color primaryColor = Color(0xFFff0e55);
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
              "Tell us about yourself",
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            AutoSizeText(
              "So we can find people who like you\nfor you",
              style: TextStyle(fontSize: 19, fontFamily: 'Quicksand'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Image.asset("assets/images/tell_us.png"),
            SizedBox(
              height: _height * 0.05,
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
                    profile.picturesUrl = new List<String>();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => UserImages(
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
