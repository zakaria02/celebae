import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class AboutYou extends StatefulWidget {
  Profile profile;
  String source;
  AboutYou({this.profile, this.source});
  @override
  State<StatefulWidget> createState() {
    return _AboutYouState(profile: profile, source: source);
  }
}

class _AboutYouState extends State<AboutYou> with TickerProviderStateMixin {
  Profile profile;
  String source;
  _AboutYouState({this.profile, this.source});
  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);
  int changed = 0;
  bool _state = false;
  String _ethnicity,
      _religion,
      _sign,
      _politic,
      _langue,
      _education,
      _employement;
  List<String> _ethnicities = [
    "(leave this blank)",
    "Asian",
    "Black",
    "Hispanic/Latin",
    "Indian",
    "Middle Eastern",
    "Native American",
    "Pacific Islander",
    "White",
    "Other"
  ],
      _religions = [
    "(leave this blank)",
    "Agnosticism",
    "Atheism",
    "Christianity",
    "Judaism",
    "Catholicism",
    "Islam",
    "Hinduism",
    "Buddhism",
    "Sikh",
    "Other"
  ],
      _signs = [
    "(leave this blank)",
    "Aquarius",
    "Pisces",
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn"
  ],
      _politics = [
    "(leave this blank)",
    "Politically liberal",
    "Politically moderate",
    "Plitically conservative",
    "Other"
  ],
      _langues = [
    "(leave this blank)",
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Basque",
    "Bengali",
    "Byelorussian",
    "Burmese",
    "Bulgarian",
    "Catalan",
    "Czech",
    "Chinese",
    "Croatian",
    "Danish",
    "Dari",
    "Dzongkha",
    "Dutch",
    "English",
    "Esperanto",
    "Estonian",
    "Faroese",
    "Farsi",
    "Finnish",
    "French",
    "Gaelic",
    "Galician",
    "German",
    "Greek",
    "Hebrew",
    "Hindi",
    "Hungarian",
    "Icelandic",
    "Indonesian",
    "Inuktitut (Eskimo)",
    "Italian",
    "Japanese",
    "Khmer",
    "Korean",
    "Kurdish",
    "Laotian",
    "Latvian",
    "Lappish",
    "Lithuanian",
    "Macedonian",
    "Malay",
    "Maltese",
    "Nepali",
    "Norwegian",
    "Pashto",
    "Polish",
    "Portuguese",
    "Romanian",
    "Russian",
    "Scots",
    "Serbian",
    "Slovak",
    "Slovenian",
    "Somali",
    "Spanish",
    "Swedish",
    "Swahili",
    "Tagalog-Filipino",
    "Tajik",
    "Tamil",
    "Thai",
    "Tibetan",
    "Tigrinya",
    "Tongan",
    "Turkish",
    "Turkmen",
    "Ucrainian",
    "Urdu",
    "Uzbek",
    "Vietnamese",
    "Welsh"
  ],
      _educations = [
    "(leave this blank)",
    "High school",
    "Tade/tech school",
    "In college",
    "Undergraduate degree",
    "In grad school",
    "Graduate degree"
  ],
      _employments = [
    "(leave this blank)",
    "Full-time",
    "Part-time",
    "Freelance",
    "Self-employed",
    "Unemployed",
    "Retired"
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
    profile.ethnicity = _ethnicity;
    profile.religion = _religion;
    profile.sign = _sign;
    profile.politic = _politic;
    profile.employement = _employement;
    profile.education = _education;
    profile.langue = _langue;
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
      "ethnicity": profile.ethnicity,
      "religion": profile.religion,
      "sign": profile.sign,
      "politic": profile.politic,
      "employement": profile.employement,
      "education": profile.education,
      "langue": profile.langue,
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
    _ethnicity = profile.ethnicity;
    _religion = profile.religion;
    _sign = profile.sign;
    _politic = profile.politic;
    _langue = profile.langue;
    _employement = profile.employement;
    _education = profile.education;
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
                    "ETHNICITY :",
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
                  value: _ethnicity,
                  items: _ethnicities.map((String value) {
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
                      _ethnicity = value;
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
                    "RELIGION :",
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
                  value: _religion,
                  items: _religions.map((String value) {
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
                      _religion = value;
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
                    "SIGN :",
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
                  value: _sign,
                  items: _signs.map((String value) {
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
                      _sign = value;
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
                    "POLITIC :",
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
                  value: _politic,
                  items: _politics.map((String value) {
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
                      _politic = value;
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
                    "EMPLOYEMENT :",
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
                  value: _employement,
                  items: _employments.map((String value) {
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
                      _employement = value;
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
                    "EDUCATION :",
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
                  value: _education,
                  items: _educations.map((String value) {
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
                      _education = value;
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
                    "SPEAKS :",
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
                  value: _langue,
                  items: _langues.map((String value) {
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
                      _langue = value;
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
