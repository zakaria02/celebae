import '../../../../model/profile.dart';
import '../../../../widgets/error_message_widget.dart';
import '../../../../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BasicsView extends StatefulWidget {
  Profile profile;
  String source;
  BasicsView({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _BasicsViewState(profile: profile, source: source);
  }
}

const int _LEGALAGE = 157680;

class _BasicsViewState extends State<BasicsView> with TickerProviderStateMixin {
  Profile profile;
  String source;
  _BasicsViewState({this.profile, this.source});
  double _height = 0, _width = 0;
  String _name = "", _dateBirth = "", _country = "", _city = "";
  DateTime dd;
  int changed = 0;
  bool _birthV = true, _enabledLocation = false, _state = false;
  final formKey = new GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      prefixIcon:
          hint == "Country" ? Icon(Icons.place) : Icon(Icons.location_city),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      contentPadding:
          const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    );
  }

  InputDecoration buildInputNameDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      contentPadding:
          const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    );
  }

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
        changed++;
      });
  }

  bool _isLegalAge(DateTime dd) {
    return DateTime.now().difference(dd).inHours > _LEGALAGE;
  }

  Widget _builBirthdayButton() {
    return Container(
      height: 57,
      child: RaisedButton(
        onPressed: _selectDate,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              _dateBirth,
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Poppins', color: Colors.grey[600]),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
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
        "SAVE",
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
        changed++;
      });
    } catch (e) {
      print(e);
    }
  }

  void _validateInputs() {
    if (formKey.currentState.validate() && _birthV) {
      formKey.currentState.save();
      if (!_state) animateButton();
      setState(() {
        profile.name = _name;
        profile.birthday = dd;
        profile.age = (DateTime.now().difference(dd).inDays / 365).round();
        profile.country = _country;
        profile.city = _city;
        if (_currentPosition != null) {
          profile.long = _currentPosition.longitude;
          profile.lat = _currentPosition.latitude;
        } else {
          profile.long = 0;
          profile.lat = 0;
        }
      });
      update(profile.uid);
    }
  }

  updateUsername(value, userUpdateInfo) async {
    await value.updateProfile(userUpdateInfo);
  }

  update(uid) async {
    final user = Provider.of(context).auth.getCurrentUser();
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    user.then((value) async {
      updateUsername(value, userUpdateInfo);
      updateData(uid);
    });
  }

  updateData(uid) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .document(source)
        .updateData({
      "birthday": profile.birthday,
      "country": profile.country,
      "city": profile.city,
      "longitude": profile.long,
      "latitude": profile.lat,
    }).then((value) {
      print("Updated");
      setState(() {
        _state = false;
      });
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dd = profile.birthday;
    _dateBirth = profile.birthday.toString().substring(0, 10);
    _name = profile.name;
    _country = profile.country;
    _city = profile.city;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Basics",
          style: TextStyle(
              fontFamily: "Poppins", color: Colors.white, fontSize: 19),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.05,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "FIRST NAME :",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                TextFormField(
                  controller: TextEditingController(text: _name),
                  decoration: buildInputNameDecoration("First Name"),
                  onChanged: (value) {
                    _name = value;
                    changed++;
                  },
                  onSaved: (value) {
                    _name = value;
                    changed++;
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'This field is obligatory';
                    return null;
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "BIRTHDAY :",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                _builBirthdayButton(),
                SizedBox(
                  height: _height * 0.02,
                ),
                Visibility(
                  visible: !_birthV,
                  child: ErrorMessage(text: "You must have at least 18 yo"),
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "LOCATION :",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Visibility(
                  visible: !_enabledLocation,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 57,
                        child: RaisedButton(
                          onPressed: _state
                              ? null
                              : () {
                                  if (!_state) animateButton();
                                  _getCurrentLocation();
                                },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.place,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              _state
                                  ? Text(
                                      "Uploading your current location ...",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          color: Colors.grey[600]),
                                    )
                                  : Text(
                                      "Set to my current location",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          color: Colors.grey[600]),
                                    ),
                            ],
                          ),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Type in my current location ?",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: primaryColor),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _enabledLocation = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _enabledLocation,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: TextEditingController(text: _country),
                        decoration: buildInputDecoration("Country"),
                        onChanged: (value) {
                          _country = value;
                          changed++;
                        },
                        onSaved: (value) {
                          _country = value;
                          changed++;
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return "This field is obligatory";
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: _city),
                        decoration: buildInputDecoration("City"),
                        onChanged: (value) {
                          _city = value;
                          changed++;
                        },
                        onSaved: (value) {
                          _city = value;
                          changed++;
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return "This field is obligatory";
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Set to my current location ?",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: primaryColor),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _enabledLocation = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                Container(
                  height: 57,
                  width: _width,
                  child: RaisedButton(
                    onPressed: _state || changed == 0 ? null : _validateInputs,
                    child: _builButtonChild(),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
