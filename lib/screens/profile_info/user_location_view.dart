import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import 'interest_view.dart';
import '../../model/profile.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  UserLocation({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _UserLocationState(profile: profile, idealPerson: idealPerson);
  }
}

class _UserLocationState extends State<UserLocation>
    with TickerProviderStateMixin {
  final Color primaryColor = Color(0xFFff0e55);
  bool _enabledLocation = false, _state = false;
  String _country, _city;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  final formKey = new GlobalKey<FormState>();
  Profile profile;
  IdealPerson idealPerson;
  _UserLocationState({this.profile, this.idealPerson});

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: hint == "Country"
          ? Icon(
              Icons.place,
              color: primaryColor,
            )
          : Icon(
              Icons.location_city,
              color: primaryColor,
            ),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
      //enabledBorder: OutlineInputBorder(
      //borderSide: BorderSide(color: Colors.white, width: 0.0),
      //),
      contentPadding:
          const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    );
  }

  _getCurrentLocation() {
    animateButton();
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _country = place.country;
        _city = place.locality;
        print("country : $_country city : $_city");
        _enabledLocation = true;
        _state = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void animateButton() {
    var controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    controller.forward();
    setState(() {
      _state = true;
    });
  }

  Widget _builButtonChild() {
    if (!_state) {
      return Text(
        "Enable location services",
        style:
            TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 18),
      );
    } else {
      return SizedBox(
        height: 26.0,
        width: 26.0,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }

  void _validateInputs() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        profile.country = _country;
        profile.city = _city;
        if (_currentPosition != null) {
          profile.long = _currentPosition.longitude;
          profile.lat = _currentPosition.latitude;
        }
      });
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => WelcomeInterest(
                  profile: profile,
                  idealPerson: idealPerson,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
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
              "Where do you live?",
              style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            Visibility(
              visible: !_enabledLocation,
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/location_image.png"),
                  SizedBox(
                    height: _height * 0.06,
                  ),
                  AutoSizeText(
                    "Fill out your location\nautomatically by enabling\nlocation services.",
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Container(
                    width: _width * 0.7,
                    height: _height * 0.07,
                    child: RaisedButton(
                      color: primaryColor,
                      child: _builButtonChild(),
                      onPressed: !_state ? _getCurrentLocation : null,
                    ),
                  ),
                  Container(
                    width: _width * 0.7,
                    height: _height * 0.07,
                    child: MaterialButton(
                        child: Text(
                          "No thanks",
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 18),
                        ),
                        onPressed: !_state
                            ? () {
                                setState(() {
                                  _enabledLocation = true;
                                });
                              }
                            : null),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _enabledLocation,
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.1,
                      ),
                      TextFormField(
                          style: TextStyle(fontSize: 22),
                          controller: TextEditingController(text: _country),
                          decoration: buildSignUpInputDecoration("Country"),
                          onSaved: (value) => _country = value,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field is obligatory!';
                            return null;
                          }),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      TextFormField(
                          style: TextStyle(fontSize: 22),
                          controller: TextEditingController(text: _city),
                          decoration: buildSignUpInputDecoration("City"),
                          onSaved: (value) => _city = value,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field is obligatory!';
                            return null;
                          }),
                      SizedBox(
                        height: _height * 0.1,
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
                            onPressed: _validateInputs),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
