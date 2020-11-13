import 'package:celebae/widgets/error_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class GenderOriontationRelationship extends StatefulWidget {
  Profile profile;
  String source;
  GenderOriontationRelationship({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _GenderOriontationRelationshipState(
        profile: profile, source: source);
  }
}

class _GenderOriontationRelationshipState
    extends State<GenderOriontationRelationship> with TickerProviderStateMixin {
  Profile profile;
  String source;
  _GenderOriontationRelationshipState({this.profile, this.source});
  double _height = 0;
  double _width = 0;
  int changed = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  bool visible = false, _state = false;
  String _gender = "Man";
  List<String> _genders = ["Man", "Woman", "Other"];
  String _relationship = "Single";
  List<String> _relationships = ["Single", "Partnered", "Married"];
  List<bool> _selected = new List<bool>(20);
  List<String> orientation = [
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

  List<Widget> _buildOriontations() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < orientation.length; i++) {
      if (_selectedOriontation.contains(orientation[i])) {
        _selected[i] = true;
      } else
        _selected[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              orientation[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selected[i],
              onChanged: (val) {
                setState(() {
                  _selected[i] = val;
                  if (_selected[i]) {
                    if (_selectedOriontation.length < 5) {
                      _selectedOriontation.add(orientation[i]);
                    } else
                      _selected[i] = false;
                  } else {
                    if (_selectedOriontation.length != 1) {
                      _selectedOriontation.remove(orientation[i]);
                    } else
                      _selected[i] = true;
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
    profile.gender = _gender;
    profile.orientation = _selectedOriontation;
    profile.relationship = _relationship;
    if (profile.gender != null &&
        profile.orientation.length != 0 &&
        profile.relationship != null) {
      if (!_state) animateButton();
      updateData(profile.uid);
    }
  }

  updateData(uid) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .document(source)
        .updateData({
      "gender": profile.gender,
      "orientation": profile.orientation,
      "relationship": profile.relationship,
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
    super.initState();
    _selectedOriontation = profile.orientation;
    _gender = profile.gender;
    _relationship = profile.relationship;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                color: Colors.white,
                width: _width,
                child: DropdownButton<String>(
                  value: _gender,
                  items: _genders.map((String value) {
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
                      _gender = value;
                      changed++;
                    });
                  },
                ),
              ),
              SizedBox(
                height: _height * 0.05,
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
                      visible = !visible;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${_selectedOriontation.join(", ")}",
                        style: TextStyle(
                            fontSize: 9,
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
                visible: visible,
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
              Visibility(
                visible: _selectedOriontation.length == 0,
                child: ErrorMessage(text: "Make a choice !!"),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "RELATIONSHIP :",
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
                  value: _relationship,
                  items: _relationships.map((String value) {
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
                      _relationship = value;
                      changed++;
                    });
                  },
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
