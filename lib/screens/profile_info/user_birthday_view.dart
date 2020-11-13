import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import 'package:celebae/screens/profile_info/user_location_view.dart';
import '../../model/profile.dart';
import '../../widgets/error_message_widget.dart';
import 'package:flutter/material.dart';

class UserBirthday extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  UserBirthday({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _UserBirthdayState(profile: this.profile, idealPerson: idealPerson);
  }
}

const int _LEGALAGE = 157680;

class _UserBirthdayState extends State<UserBirthday> {
  final Color primaryColor = Color(0xFFff0e55);
  double _height = 0, _width = 0;
  bool _birthV = false, _err = false;
  DateTime dd;
  String _dateBirth = "Choose Your Birthday";
  Profile profile;
  IdealPerson idealPerson;
  _UserBirthdayState({this.profile, this.idealPerson});

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: dd == null ? new DateTime.now() : dd,
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
    );
    if (picked != null)
      setState(() {
        dd = picked;
        _dateBirth = picked.toString().substring(0, 10);
        _birthV = _isLegalAge(dd);
      });
  }

  bool _isLegalAge(DateTime dd) {
    return DateTime.now().difference(dd).inHours > _LEGALAGE;
  }

  Widget _builBirthdayButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(_width * 5 / 100, 0, _width * 5 / 100, 0),
      width: _width,
      height: 57,
      child: RaisedButton(
          onPressed: _selectDate,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: primaryColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                _dateBirth,
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
            ],
          ),
          color: Colors.white,
          shape: new RoundedRectangleBorder(
              side: BorderSide(
            color: (dd == null || _birthV) ? primaryColor : Colors.red[700],
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
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
                        "About you",
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
              "When were you born?",
              style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            Image.asset("assets/images/birthday_image.png"),
            SizedBox(
              height: _height * 0.06,
            ),
            _builBirthdayButton(),
            SizedBox(
              height: _height * 0.03,
            ),
            Visibility(
              visible: _err,
              child: ErrorMessage(
                  text: dd == null
                      ? "Please Enter a valid birthday !"
                      : "You must have at least 18 yo !"),
            ),
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
                    if (dd == null || !_birthV) {
                      setState(() {
                        _err = true;
                      });
                    } else {
                      setState(() {
                        _err = false;
                        profile.birthday = dd;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserLocation(
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
