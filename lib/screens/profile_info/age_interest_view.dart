import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../model/profile.dart';
import 'tell_us_view.dart';
import 'package:celebae/widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeInterest extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  AgeInterest({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _AgeInterestState(profile: profile, idealPerson: idealPerson);
  }
}

class _AgeInterestState extends State<AgeInterest> {
  final Color primaryColor = Color(0xFFff0e55);
  int _minAge = 18, _maxAge = 30;
  bool _err = false;
  Profile profile;
  IdealPerson idealPerson;
  _AgeInterestState({this.profile, this.idealPerson});
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
                        "Ideal person",
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
              "How old should they be?",
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: primaryColor, // highlted color
                    ),
                    child: NumberPicker.integer(
                      initialValue: _minAge,
                      minValue: 18,
                      maxValue: 70,
                      onChanged: (val) {
                        setState(() {
                          _minAge = val;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Text(
                    "-",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 40),
                  ),
                  Spacer(),
                  Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: primaryColor, // highlted color
                    ),
                    child: NumberPicker.integer(
                      initialValue: _maxAge,
                      minValue: 18,
                      maxValue: 70,
                      onChanged: (val) {
                        setState(() {
                          _maxAge = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Visibility(
                visible: _err,
                child: ErrorMessage(
                    text:
                        "The maximum age must be greater than the minimum age"),
              ),
            ),
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
                    if (_minAge > _maxAge) {
                      setState(() {
                        _err = true;
                      });
                    } else {
                      setState(() {
                        _err = false;
                        idealPerson.minAge = _minAge;
                        idealPerson.maxAge = _maxAge;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => TellUs(
                                  profile: profile,
                                  idealPerson: idealPerson,
                                )),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
