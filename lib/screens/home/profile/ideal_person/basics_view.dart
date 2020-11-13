import '../../../../model/idealPerson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../widgets/error_message_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class BasicsViewIdeal extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  BasicsViewIdeal({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _BasicsViewIdealState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _BasicsViewIdealState extends State<BasicsViewIdeal>
    with TickerProviderStateMixin {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  _BasicsViewIdealState({this.profile, this.idealPerson, this.source});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  List<String> _genders = ["Men", "Women", "Others"];
  List<String> _selectedGenders = new List<String>();
  List<String> _orientation = [
    "Straight",
    "Gay",
    "Bisexual",
    "Lesbian",
    "Queer",
    "Pansexual",
    "Questioning",
    "Heteroflexible",
    "Homoflexible",
    "Asexual",
    "Gray-asexual",
    "Demisexual",
    "Reciprosexual",
    "Akiosexual",
    "Aceflux",
    "Grayromantic",
    "Demiromantic",
    "Recipromantic",
    "Akioromantic",
    "Aroflux",
  ];
  List<String> _selectedOriontation = new List<String>();
  List<String> _connections = [
    "New friends",
    "Long-term dating",
    "Short-term dating",
    "Hookups"
  ];
  List<String> _selectedConnections = new List<String>();
  List<String> _status = ["Single", "Partnered", "Married"];
  List<String> _selectedStatus = new List<String>();
  List<String> _distances = [
    "5",
    "10",
    "25",
    "50",
    "100",
    "250",
    "500",
    "Anywhere"
  ];
  String _distance;
  int _minAge, _maxAge;
  List<bool> visible = new List<bool>(6),
      _selectedG = new List<bool>(3),
      _selectedO = new List<bool>(20),
      _selectedC = new List<bool>(4),
      _selectedS = new List<bool>(3);
  int changed = 0;
  bool _state = false, _err = false;

  List<Widget> _buildGenders() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _genders.length; i++) {
      if (_selectedGenders.contains(_genders[i])) {
        _selectedG[i] = true;
      } else
        _selectedG[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _genders[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedG[i],
              onChanged: (val) {
                setState(() {
                  _selectedG[i] = val;
                  print(val);
                  print(_selectedG[i]);
                  if (_selectedG[i]) {
                    _selectedGenders.add(_genders[i]);
                  } else {
                    if (_selectedGenders.length != 1) {
                      _selectedGenders.remove(_genders[i]);
                    } else
                      _selectedG[i] = true;
                  }
                  changed++;
                });
                print(_selectedGenders.join(", "));
              },
              activeColor: primaryColor,
            ),
          ],
        ),
      );
      list.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    return list;
  }

  List<Widget> _buildOriontations() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _orientation.length; i++) {
      if (_selectedOriontation.contains(_orientation[i])) {
        _selectedO[i] = true;
      } else
        _selectedO[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _orientation[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedO[i],
              onChanged: (val) {
                setState(() {
                  _selectedO[i] = val;
                  print(val);
                  print(_selectedO[i]);
                  if (_selectedO[i]) {
                    _selectedOriontation.add(_orientation[i]);
                  } else {
                    if (_selectedOriontation.length != 1) {
                      _selectedOriontation.remove(_orientation[i]);
                    } else
                      _selectedO[i] = true;
                  }
                  changed++;
                });
                print(_selectedOriontation.join(", "));
              },
              activeColor: primaryColor,
            ),
          ],
        ),
      );
      list.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    return list;
  }

  List<Widget> _buildConnections() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _connections.length; i++) {
      if (_selectedConnections.contains(_connections[i])) {
        _selectedC[i] = true;
      } else
        _selectedC[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _connections[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedC[i],
              onChanged: (val) {
                setState(() {
                  _selectedC[i] = val;
                  print(val);
                  print(_selectedC[i]);
                  if (_selectedC[i]) {
                    _selectedConnections.add(_connections[i]);
                  } else {
                    if (_selectedConnections.length != 1) {
                      _selectedConnections.remove(_connections[i]);
                    } else
                      _selectedC[i] = true;
                  }
                  changed++;
                });
                print(_selectedConnections.join(", "));
              },
              activeColor: primaryColor,
            ),
          ],
        ),
      );
      list.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    return list;
  }

  List<Widget> _buildStatus() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _status.length; i++) {
      if (_selectedStatus.contains(_status[i])) {
        _selectedS[i] = true;
      } else
        _selectedS[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _status[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedS[i],
              onChanged: (val) {
                setState(() {
                  _selectedS[i] = val;
                  print(val);
                  print(_selectedS[i]);
                  if (_selectedS[i]) {
                    _selectedStatus.add(_status[i]);
                  } else {
                    if (_selectedStatus.length != 1) {
                      _selectedStatus.remove(_status[i]);
                    } else
                      _selectedS[i] = true;
                  }
                  changed++;
                });
                print(_selectedStatus.join(", "));
              },
              activeColor: primaryColor,
            ),
          ],
        ),
      );
      list.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    return list;
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

  void _validateInputs() {
    if (_minAge <= _maxAge) {
      idealPerson.genders = _selectedGenders;
      idealPerson.orientations = _selectedOriontation;
      idealPerson.minAge = _minAge;
      idealPerson.maxAge = _maxAge;
      idealPerson.distance = _distance;
      idealPerson.connections = _selectedConnections;
      idealPerson.status = _selectedStatus;
      if (changed > 0) {
        if (!_state) animateButton();
        updateData(profile.uid);
      }
    }
  }

  updateData(uid) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('idealPerson')
        .document(source)
        .updateData({
      "genders": idealPerson.genders,
      "orientations": idealPerson.orientations,
      "minAge": idealPerson.minAge,
      "maxAge": idealPerson.maxAge,
      "distance": idealPerson.distance,
      "connections": idealPerson.connections,
      "status": idealPerson.status,
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
    _selectedGenders = idealPerson.genders;
    _selectedOriontation = idealPerson.orientations;
    _minAge = idealPerson.minAge;
    _maxAge = idealPerson.maxAge;
    _distance = idealPerson.distance;
    _selectedConnections = idealPerson.connections;
    _selectedStatus = idealPerson.status;
    for (int i = 0; i < visible.length; i++) {
      visible[i] = false;
    }
    super.initState();
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
      body: Container(
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
                    "GENDER :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                height: 57,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visible[0] = !visible[0];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedGenders.length == _genders.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedGenders[0]}...",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: visible[0],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildGenders(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "ORIENTATION :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                height: 57,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visible[1] = !visible[1];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedOriontation.length == _orientation.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedOriontation[0]}...",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: visible[1],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildOriontations(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "AGE :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                height: 57,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visible[2] = !visible[2];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "$_minAge - $_maxAge",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Colors.grey[600]),
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: visible[2],
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
                            changed++;
                            if (_minAge > _maxAge)
                              _err = true;
                            else
                              _err = false;
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
                            changed++;
                            if (_minAge > _maxAge)
                              _err = true;
                            else
                              _err = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: _err,
                child: ErrorMessage(
                    text:
                        "The maximum age must be greater than the minimum age"),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "DISTANCE(KM) :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                color: Colors.white,
                width: _width,
                child: DropdownButton<String>(
                  value: _distance,
                  items: _distances.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        width: _width - _width * 0.2,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _distance = value;
                      changed++;
                    });
                  },
                ),
              ),
              SizedBox(
                height: _height * 0.04,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "CONNECTIONS :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                height: 57,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visible[4] = !visible[4];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedConnections.length == _connections.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedConnections[0]}...",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: visible[4],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildConnections(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "THEIR STATUS :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                height: 57,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visible[5] = !visible[5];
                      print(visible[5]);
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedStatus.length == _status.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedStatus[0]}...",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: visible[5],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildStatus(),
                        ),
                      ),
                    ),
                  ),
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
    );
  }
}
