import 'package:celebae/model/idealPerson.dart';
import 'package:celebae/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LifeStyleView extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  LifeStyleView({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _LifeStyleViewState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _LifeStyleViewState extends State<LifeStyleView>
    with TickerProviderStateMixin {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  _LifeStyleViewState({this.profile, this.idealPerson, this.source});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  bool _state = false;
  List<bool> visible = new List<bool>(4),
      _selectedA = new List<bool>(3),
      _selectedS = new List<bool>(3),
      _selectedM = new List<bool>(3),
      _selectedD = new List<bool>(11);
  List<String> _alcohols = ["Never", "Sometimes", "Often"],
      _selectedAlcohols,
      _selectedSmoking,
      _selectedMarijuana,
      _diets = [
    "Omnivore",
    "Vegetarian",
    "Vegan",
    "Kosher",
    "Halal",
    "Gluten Free",
    "Pescatarian",
    "Jain",
    "Lactovegetarian",
    "Intermittent Fasting",
    "Ketogenic"
  ],
      _selectedDiets;

  List<Widget> _buildAlcohols() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _alcohols.length; i++) {
      if (_selectedAlcohols.contains(_alcohols[i])) {
        _selectedA[i] = true;
      } else
        _selectedA[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _alcohols[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedA[i],
              onChanged: (val) {
                setState(() {
                  _selectedA[i] = val;
                  print(val);
                  print(_selectedA[i]);
                  if (_selectedA[i]) {
                    _selectedAlcohols.add(_alcohols[i]);
                  } else {
                    if (_selectedAlcohols.length != 1) {
                      _selectedAlcohols.remove(_alcohols[i]);
                    } else
                      _selectedA[i] = true;
                  }
                  changed++;
                });
                print(_selectedAlcohols.join(", "));
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

  List<Widget> _buildSmoking() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _alcohols.length; i++) {
      if (_selectedSmoking.contains(_alcohols[i])) {
        _selectedS[i] = true;
      } else
        _selectedS[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _alcohols[i],
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
                    _selectedSmoking.add(_alcohols[i]);
                  } else {
                    if (_selectedSmoking.length != 1) {
                      _selectedSmoking.remove(_alcohols[i]);
                    } else
                      _selectedS[i] = true;
                  }
                  changed++;
                });
                print(_selectedSmoking.join(", "));
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

  List<Widget> _buildMarijuana() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _alcohols.length; i++) {
      if (_selectedMarijuana.contains(_alcohols[i])) {
        _selectedM[i] = true;
      } else
        _selectedM[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _alcohols[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedM[i],
              onChanged: (val) {
                setState(() {
                  _selectedM[i] = val;
                  print(val);
                  print(_selectedM[i]);
                  if (_selectedM[i]) {
                    _selectedMarijuana.add(_alcohols[i]);
                  } else {
                    if (_selectedMarijuana.length != 1) {
                      _selectedMarijuana.remove(_alcohols[i]);
                    } else
                      _selectedM[i] = true;
                  }
                  changed++;
                });
                print(_selectedMarijuana.join(", "));
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

  List<Widget> _buildDiet() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _diets.length; i++) {
      if (_selectedDiets.contains(_diets[i])) {
        _selectedD[i] = true;
      } else
        _selectedD[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _diets[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedD[i],
              onChanged: (val) {
                setState(() {
                  _selectedD[i] = val;
                  print(val);
                  print(_selectedD[i]);
                  if (_selectedD[i]) {
                    _selectedDiets.add(_diets[i]);
                  } else {
                    if (_selectedDiets.length != 1) {
                      _selectedDiets.remove(_diets[i]);
                    } else
                      _selectedD[i] = true;
                  }
                  changed++;
                });
                print(_selectedDiets.join(", "));
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
    idealPerson.alcohol = _selectedAlcohols;
    idealPerson.smoking = _selectedSmoking;
    idealPerson.marijuana = _selectedMarijuana;
    idealPerson.diets = _selectedDiets;
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
      "alcohol": idealPerson.alcohol,
      "smoking": idealPerson.smoking,
      "marijuana": idealPerson.marijuana,
      "diets": idealPerson.diets,
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
    for (int i = 0; i < visible.length; i++) visible[i] = false;
    _selectedAlcohols = idealPerson.alcohol;
    _selectedSmoking = idealPerson.smoking;
    _selectedMarijuana = idealPerson.marijuana;
    _selectedDiets = idealPerson.diets;
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
          "Lifestyle",
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
                    "ALCOHOL :",
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
                      _selectedAlcohols.length == _alcohols.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedAlcohols[0]}...",
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
                          children: _buildAlcohols(),
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
                    "SMOKING :",
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
                      _selectedSmoking.length == _alcohols.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedSmoking[0]}...",
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
                          children: _buildSmoking(),
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
                    "MARIJUANA :",
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
                      _selectedMarijuana.length == _alcohols.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedMarijuana[0]}...",
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
                          children: _buildMarijuana(),
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
                    "DIET :",
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
                      visible[3] = !visible[3];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedDiets.length == _diets.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedDiets[0]}...",
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
                visible: visible[3],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildDiet(),
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
