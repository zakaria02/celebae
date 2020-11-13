import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class PronounView extends StatefulWidget {
  Profile profile;
  String source;
  PronounView({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _PronounViewState(profile: profile, source: source);
  }
}

enum SingingCharacter { livethisblank, heHim, sheHer, theyThem }

class _PronounViewState extends State<PronounView>
    with TickerProviderStateMixin {
  Profile profile;
  String source;
  _PronounViewState({this.profile, this.source});
  SingingCharacter sc;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  bool _state = false;
  int changed = 0;
  double _height = 0, _width = 0;
  String _pronoun = "";
  List<Widget> list = new List<Widget>();
  List<String> _pronouns = [
    "(leave this blank)",
    "He/Him",
    "She/Her",
    "They/Them"
  ];

  List<Widget> _buildRadio() {
    list.clear();
    for (int i = 0; i < _pronouns.length; i++) {
      if (_pronouns[i] == _pronoun) {
        if (i == 0)
          sc = SingingCharacter.livethisblank;
        else if (i == 1)
          sc = SingingCharacter.heHim;
        else if (i == 2)
          sc = SingingCharacter.sheHer;
        else if (i == 3) sc = SingingCharacter.theyThem;
      }
    }
    for (int i = 0; i < _pronouns.length; i++) {
      list.add(
        Row(
          children: <Widget>[
            Text(
              _pronouns[i],
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
                  ? SingingCharacter.livethisblank
                  : (i == 1)
                      ? SingingCharacter.heHim
                      : (i == 2)
                          ? SingingCharacter.sheHer
                          : SingingCharacter.theyThem,
              groupValue: sc,
              onChanged: (value) {
                setState(() {
                  sc = value;
                  _pronoun = _pronouns[i];
                  print(_pronoun);
                  changed++;
                });
              },
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
    if (!_state) animateButton();
    profile.pronoun = _pronoun;
    if (profile.pronoun != null) updateData(profile.uid);
  }

  updateData(uid) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .document(source)
        .updateData({
      "pronoun": profile.pronoun,
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
    _pronoun = profile.pronoun;
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AutoSizeText(
                    "Would you like to be called :",
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
                      child: Column(children: _buildRadio()),
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
