import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class SmokingDrinking extends StatefulWidget {
  Profile profile;
  String source;
  SmokingDrinking({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _SmokingDrinkingState(profile: profile, source: source);
  }
}

class _SmokingDrinkingState extends State<SmokingDrinking>
    with TickerProviderStateMixin {
  Profile profile;
  String source;
  _SmokingDrinkingState({this.profile, this.source});
  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  int changed = 0;
  bool _state = false;
  String _diet, _smoking, _drinking, _marijuana;
  List<String> _diets = [
    "(leave this blank)",
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
      _smokes = [
    "(leave this blank)",
    "Often",
    "Sometimes",
    "Never",
  ],
      _drinkes = [
    "(leave this blank)",
    "Often",
    "Sometimes",
    "Never",
  ],
      _maruijanas = [
    "(leave this blank)",
    "Often",
    "Sometimes",
    "Never",
  ];
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
    profile.diet = _diet;
    profile.smoking = _smoking;
    profile.drinking = _drinking;
    profile.marijuana = _marijuana;
    if (changed > 0) {
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
      "diet": profile.diet,
      "smoking": profile.smoking,
      "drinking": profile.drinking,
      "marijuana": profile.marijuana,
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
    _diet = profile.diet;
    _smoking = profile.smoking;
    _drinking = profile.drinking;
    _marijuana = profile.marijuana;
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
          "Details",
          style: TextStyle(
              fontFamily: "Poppins", color: Colors.white, fontSize: 19),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.05,
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
                color: Colors.white,
                width: _width,
                child: DropdownButton<String>(
                  value: _diet,
                  items: _diets.map((String value) {
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
                      _diet = value;
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
                    "SMOKING :",
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
                  value: _smoking,
                  items: _smokes.map((String value) {
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
                      _smoking = value;
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
                    "DRINKING :",
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
                  value: _drinking,
                  items: _drinkes.map((String value) {
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
                      _drinking = value;
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
                    "MARIJUANA :",
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
                  value: _marijuana,
                  items: _maruijanas.map((String value) {
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
                      _marijuana = value;
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
