import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class ChildrenPets extends StatefulWidget {
  Profile profile;
  String source;
  ChildrenPets({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _ChildrenPetsState(profile: profile, source: source);
  }
}

enum SingingCharacterHas { livethisblank, hasKids, doesntHasKids }
enum SingingCharacterWant {
  livethisblank,
  mightWantKids,
  wantsKids,
  doesntWantKids
}

class _ChildrenPetsState extends State<ChildrenPets>
    with TickerProviderStateMixin {
  Profile profile;
  String source;
  _ChildrenPetsState({this.profile, this.source});
  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  int changed = 0;
  bool _state = false;
  List<Widget> listHas = new List<Widget>();
  List<Widget> listWant = new List<Widget>();
  SingingCharacterHas scH;
  SingingCharacterWant scW;
  String _hasKids, _wantKids, _pet;
  List<String> _hasKidsRadio = [
    "(leave this blank)",
    "Has kid(s)",
    "Doesn't have kids"
  ],
      _wantKidsRadio = [
    "(leave this blank)",
    "Might want kids",
    "Wants kids",
    "Doesn't want kids"
  ],
      _pets = [
    "(leave this blank)",
    "Doesn't have pet(s)",
    "Has other pet(s)",
    "Has cat(s)",
    "Has dog(s)"
  ];

  List<Widget> _buildRadioHas() {
    listHas.clear();
    for (int i = 0; i < _hasKidsRadio.length; i++) {
      if (_hasKidsRadio[i] == _hasKids) {
        if (i == 0)
          scH = SingingCharacterHas.livethisblank;
        else if (i == 1)
          scH = SingingCharacterHas.hasKids;
        else if (i == 2) scH = SingingCharacterHas.doesntHasKids;
      }
    }
    for (int i = 0; i < _hasKidsRadio.length; i++) {
      listHas.add(
        Row(
          children: <Widget>[
            Text(
              _hasKidsRadio[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Radio(
              activeColor: primaryColor,
              value: (i == 0)
                  ? SingingCharacterHas.livethisblank
                  : (i == 1)
                      ? SingingCharacterHas.hasKids
                      : SingingCharacterHas.doesntHasKids,
              groupValue: scH,
              onChanged: (value) {
                setState(() {
                  scH = value;
                  _hasKids = _hasKidsRadio[i];
                  changed++;
                });
              },
            ),
          ],
        ),
      );
      listHas.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    listHas.add(SizedBox(
      height: _height * 0.05,
    ));
    return listHas;
  }

  List<Widget> _buildRadioWant() {
    listWant.clear();
    for (int i = 0; i < _wantKidsRadio.length; i++) {
      if (_wantKidsRadio[i] == _wantKids) {
        if (i == 0)
          scW = SingingCharacterWant.livethisblank;
        else if (i == 1)
          scW = SingingCharacterWant.mightWantKids;
        else if (i == 2)
          scW = SingingCharacterWant.wantsKids;
        else if (i == 3) scW = SingingCharacterWant.doesntWantKids;
      }
    }
    for (int i = 0; i < _wantKidsRadio.length; i++) {
      listWant.add(
        Row(
          children: <Widget>[
            Text(
              _wantKidsRadio[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Radio(
              activeColor: primaryColor,
              value: (i == 0)
                  ? SingingCharacterWant.livethisblank
                  : (i == 1)
                      ? SingingCharacterWant.mightWantKids
                      : (i == 2)
                          ? SingingCharacterWant.wantsKids
                          : SingingCharacterWant.doesntWantKids,
              groupValue: scW,
              onChanged: (value) {
                setState(() {
                  scW = value;
                  _wantKids = _wantKidsRadio[i];
                  changed++;
                });
              },
            ),
          ],
        ),
      );
      listWant.add(SizedBox(
        height: _height * 0.01,
      ));
    }
    return listWant;
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
    profile.hasKids = _hasKids;
    profile.wantKids = _wantKids;
    profile.pet = _pet;
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
      "hasKids": profile.hasKids,
      "wantKids": profile.wantKids,
      "pet": profile.pet,
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
    _hasKids = profile.hasKids;
    _wantKids = profile.wantKids;
    _pet = profile.pet;
    super.initState();
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
                    "CHILDREN :",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: _width * 0.85,
                  child: Card(
                    elevation: 13,
                    child: Padding(
                      padding: EdgeInsets.all(17),
                      child: Column(
                          children: _buildRadioHas() + _buildRadioWant()),
                    ),
                  ),
                ),
              ),
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
                color: Colors.white,
                width: _width,
                child: DropdownButton<String>(
                  value: _pet,
                  items: _pets.map((String value) {
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
                      _pet = value;
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
