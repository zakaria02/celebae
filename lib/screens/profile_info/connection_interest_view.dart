import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import 'age_interest_view.dart';
import '../../model/profile.dart';
import '../../widgets/error_message_widget.dart';
import 'package:flutter/material.dart';

class ConnectionInterest extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  ConnectionInterest({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _ConnectionInterestState(profile: profile, idealPerson: idealPerson);
  }
}

class _ConnectionInterestState extends State<ConnectionInterest> {
  final Color primaryColor = Color(0xFFff0e55);
  bool _hookups = false,
      _newFriends = false,
      _shortTermDating = false,
      _longTermDating = false,
      _err = false;
  List<String> connectionInterest = new List<String>();
  Profile profile;
  IdealPerson idealPerson;
  _ConnectionInterestState({this.profile, this.idealPerson});
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
              "What connections are you\nlooking for?",
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: _height * 0.35,
                width: _width * 0.85,
                child: Card(
                  elevation: 13,
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Hookups",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: _hookups,
                              onChanged: (val) {
                                setState(() {
                                  _hookups = val;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "New friends",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: _newFriends,
                              onChanged: (val) {
                                setState(() {
                                  _newFriends = val;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Short-term dating",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: _shortTermDating,
                              onChanged: (val) {
                                setState(() {
                                  _shortTermDating = val;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Long-term dating",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: _longTermDating,
                              onChanged: (val) {
                                setState(() {
                                  _longTermDating = val;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Visibility(
              visible: _err,
              child: ErrorMessage(text: "Make at least one choice !"),
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
                    if (!_hookups &&
                        !_newFriends &&
                        !_shortTermDating &&
                        !_longTermDating) {
                      setState(() {
                        _err = true;
                      });
                    } else {
                      setState(() {
                        _err = false;
                        if (_hookups) connectionInterest.add("Hookups");
                        if (_newFriends) connectionInterest.add("New friends");
                        if (_shortTermDating)
                          connectionInterest.add("Short term datting");
                        if (_longTermDating)
                          connectionInterest.add("Long term datting");
                        profile.interestConnections =
                            connectionInterest.join(" and ");
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => AgeInterest(
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
