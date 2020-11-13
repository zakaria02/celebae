import '../../../../model/profile.dart';
import '../../../../widgets/error_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../model/idealPerson.dart';
import 'package:flutter/material.dart';

class LooksView extends StatefulWidget {
  IdealPerson idealPerson;
  Profile profile;
  String source;
  LooksView({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _LooksViewState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _LooksViewState extends State<LooksView> with TickerProviderStateMixin {
  IdealPerson idealPerson;
  Profile profile;
  String source;
  _LooksViewState({this.profile, this.idealPerson, this.source});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  bool visible1 = false, visible2 = false, _err = false, _state = false;
  List<bool> _selectedBT = new List<bool>(8);
  List<String> _bodyTypes = [
    "Thin",
    "Overweight",
    "Average build",
    "Fit",
    "Jacked",
    "A little extra",
    "Curvy",
    "Full figured"
  ];
  List<String> _selectedBodyTypes;
  int _minHeight, _maxHeight;

  List<Widget> _buildBodyTypes() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _bodyTypes.length; i++) {
      if (_selectedBodyTypes.contains(_bodyTypes[i])) {
        _selectedBT[i] = true;
      } else
        _selectedBT[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _bodyTypes[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedBT[i],
              onChanged: (val) {
                setState(() {
                  _selectedBT[i] = val;
                  print(val);
                  print(_selectedBT[i]);
                  if (_selectedBT[i]) {
                    _selectedBodyTypes.add(_bodyTypes[i]);
                  } else {
                    if (_selectedBodyTypes.length != 1) {
                      _selectedBodyTypes.remove(_bodyTypes[i]);
                    } else
                      _selectedBT[i] = true;
                  }
                  changed++;
                });
                print(_selectedBodyTypes.join(", "));
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
    if (_minHeight <= _maxHeight) {
      idealPerson.bodyTypes = _selectedBodyTypes;
      idealPerson.minHeight = _minHeight;
      idealPerson.maxHeight = _maxHeight;
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
      "bodyTypes": idealPerson.bodyTypes,
      "minHeight": idealPerson.minHeight,
      "maxHeight": idealPerson.maxHeight,
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
    _selectedBodyTypes = idealPerson.bodyTypes;
    _minHeight = idealPerson.minHeight;
    _maxHeight = idealPerson.maxHeight;
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
          "Looks",
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
                    "BODY TYPES :",
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
                      visible1 = !visible1;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedBodyTypes.length == _bodyTypes.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedBodyTypes[0]}...",
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
                visible: visible1,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildBodyTypes(),
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
                    "HEIGHT:",
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
                      visible2 = !visible2;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "$_minHeight - $_maxHeight",
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
                visible: visible2,
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(
                        accentColor: primaryColor, // highlted color
                      ),
                      child: NumberPicker.integer(
                        initialValue: _minHeight,
                        minValue: 90,
                        maxValue: 242,
                        onChanged: (val) {
                          setState(() {
                            _minHeight = val;
                            changed++;
                            if (_minHeight > _maxHeight)
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
                        initialValue: _maxHeight,
                        minValue: 90,
                        maxValue: 242,
                        onChanged: (val) {
                          setState(() {
                            _maxHeight = val;
                            changed++;
                            if (_minHeight > _maxHeight)
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
                        "The maximum height must be greater than the minimum height"),
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
