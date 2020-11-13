import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class BodyTypeHeight extends StatefulWidget {
  Profile profile;
  String source;
  BodyTypeHeight({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _BodyTypeHeightState(profile: profile, source: source);
  }
}

class _BodyTypeHeightState extends State<BodyTypeHeight>
    with TickerProviderStateMixin {
  Profile profile;
  String source;
  _BodyTypeHeightState({this.profile, this.source});
  double _height = 0;
  double _width = 0;
  int changed = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  final formKey = new GlobalKey<FormState>();
  bool _state = false;
  String hg = "", _heightUnite = "", _bodyType = "";
  List<String> _heightUnites = ["cm", "Inches", "Feet"];
  List<String> _bodyTypes = [
    "(leave this blank)",
    "Thin",
    "Overweight",
    "Average build",
    "Fit",
    "Jacked",
    "A little extra",
    "Curvy",
    "Full figured"
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
    profile.height = double.parse(hg);
    profile.heightUnite = _heightUnite;
    profile.bodyType = _bodyType;
    if (profile.bodyType != null && formKey.currentState.validate()) {
      formKey.currentState.save();
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
      "height": profile.height,
      "heightUnite": profile.heightUnite,
      "bodyType": profile.bodyType,
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
    hg = profile.height.toString();
    _heightUnite = profile.heightUnite;
    _bodyType = profile.bodyType;
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
                      "HEIGHT :",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                TextFormField(
                  controller: TextEditingController(text: hg),
                  decoration: buildInputNameDecoration("HEIGHT"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    hg = value;
                    changed++;
                  },
                  onSaved: (value) {
                    hg = value;
                    changed++;
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return 'This field is obligatory';
                    else if (double.parse(value) < 0)
                      return 'The height must be gretter than 0';
                    return null;
                  },
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  color: Colors.white,
                  width: _width,
                  child: DropdownButton<String>(
                    value: _heightUnite,
                    items: _heightUnites.map((String value) {
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
                        _heightUnite = value;
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
                      "BODY TYPE :",
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
                    value: _bodyType,
                    items: _bodyTypes.map((String value) {
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
                        _bodyType = value;
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
      ),
    );
  }
}
