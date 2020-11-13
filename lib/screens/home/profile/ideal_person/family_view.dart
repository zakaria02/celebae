import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/idealPerson.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class FamilyView extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  FamilyView({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _FamilyViewState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _FamilyViewState extends State<FamilyView> with TickerProviderStateMixin {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  _FamilyViewState({this.profile, this.idealPerson, this.source});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  bool _state = false;
  List<bool> visible = [false, false, false];
  List<String> _pets = ["Dog(s)", "Cat(s)", "Other", "None"],
      _selectedPets,
      _hasKids = ["Has kid(s)", "Doesn't have kid(s)"],
      _selectedHasKids,
      _wantKids = ["Might want kid(s)", "Wants kid(s)", "Doesn't want kid(s)"],
      _selectedWantKids;
  List<bool> _selectedP = new List<bool>(4),
      _selectedHK = new List<bool>(2),
      _selectedWK = new List<bool>(3);

  List<Widget> _buildPets() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _pets.length; i++) {
      if (_selectedPets.contains(_pets[i])) {
        _selectedP[i] = true;
      } else
        _selectedP[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _pets[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedP[i],
              onChanged: (val) {
                setState(() {
                  _selectedP[i] = val;
                  print(val);
                  print(_selectedP[i]);
                  if (_selectedP[i]) {
                    _selectedPets.add(_pets[i]);
                  } else {
                    if (_selectedPets.length != 1) {
                      _selectedPets.remove(_pets[i]);
                    } else
                      _selectedP[i] = true;
                  }
                  changed++;
                });
                print(_selectedPets.join(", "));
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

  List<Widget> _buildHasKids() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _hasKids.length; i++) {
      if (_selectedHasKids.contains(_hasKids[i])) {
        _selectedHK[i] = true;
      } else
        _selectedHK[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _hasKids[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedHK[i],
              onChanged: (val) {
                setState(() {
                  _selectedHK[i] = val;
                  print(val);
                  print(_selectedHK[i]);
                  if (_selectedHK[i]) {
                    _selectedHasKids.add(_hasKids[i]);
                  } else {
                    if (_selectedHasKids.length != 1) {
                      _selectedHasKids.remove(_hasKids[i]);
                    } else
                      _selectedHK[i] = true;
                  }
                  changed++;
                });
                print(_selectedHasKids.join(", "));
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

  List<Widget> _buildWantKids() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _wantKids.length; i++) {
      if (_selectedWantKids.contains(_wantKids[i])) {
        _selectedWK[i] = true;
      } else
        _selectedWK[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _wantKids[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedWK[i],
              onChanged: (val) {
                setState(() {
                  _selectedWK[i] = val;
                  print(val);
                  print(_selectedWK[i]);
                  if (_selectedWK[i]) {
                    _selectedWantKids.add(_wantKids[i]);
                  } else {
                    if (_selectedWantKids.length != 1) {
                      _selectedWantKids.remove(_wantKids[i]);
                    } else
                      _selectedWK[i] = true;
                  }
                  changed++;
                });
                print(_selectedWantKids.join(", "));
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
    idealPerson.pets = _selectedPets;
    idealPerson.hasKids = _selectedHasKids;
    idealPerson.wantKids = _selectedWantKids;
    if (changed > 0) {
      if (!_state) animateButton();
      updateData(profile.uid);
    }
  }

  updateData(uid) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('idealPerson')
        .document(source)
        .updateData({
      "pets": idealPerson.pets,
      "hasKids": idealPerson.hasKids,
      "wantKids": idealPerson.wantKids,
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
    _selectedPets = idealPerson.pets;
    _selectedHasKids = idealPerson.hasKids;
    _selectedWantKids = idealPerson.wantKids;
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
          "Family",
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
                    "PETS :",
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
                      _selectedPets.length == _pets.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedPets[0]}...",
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
                          children: _buildPets(),
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
                    "HAS KIDS :",
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
                      _selectedHasKids.length == _hasKids.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_hasKids[0]}...",
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
                          children: _buildHasKids(),
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
                    "WANT KIDS :",
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
                      _selectedWantKids.length == _wantKids.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_wantKids[0]}...",
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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildWantKids(),
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
