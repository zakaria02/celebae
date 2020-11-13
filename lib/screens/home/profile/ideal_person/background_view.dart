import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/idealPerson.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class BackgroundView extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  BackgroundView({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _BackgroundViewState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _BackgroundViewState extends State<BackgroundView>
    with TickerProviderStateMixin {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  _BackgroundViewState({this.profile, this.idealPerson, this.source});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  bool _state = false;
  List<bool> visible = new List<bool>(7);
  List<String> _ethnicities = [
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
      _selectedEthnicities,
      _religions = [
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
      _selectedReligions,
      _signs = [
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
      _selectedSigns,
      _politics = [
    "Politically liberal",
    "Politically moderate",
    "Plitically conservative",
    "Other"
  ],
      _selectedPolitics,
      _employments = [
    "Full-time",
    "Part-time",
    "Freelance",
    "Self-employed",
    "Unemployed",
    "Retired"
  ],
      _selectedEmployments,
      _educations = [
    "High school",
    "Tade/tech school",
    "In college",
    "Undergraduate degree",
    "In grad school",
    "Graduate degree"
  ],
      _selectedEducations,
      _langues = [
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
      _selectedLangues;
  List<bool> _selectedE = new List<bool>(9),
      _selectedR = new List<bool>(10),
      _selectedS = new List<bool>(12),
      _selectedP = new List<bool>(4),
      _selectedEm = new List<bool>(6),
      _selectedEd = new List<bool>(6),
      _selectedL = new List<bool>(77);

  List<Widget> _buildEthnicities() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _ethnicities.length; i++) {
      if (_selectedEthnicities.contains(_ethnicities[i])) {
        _selectedE[i] = true;
      } else
        _selectedE[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _ethnicities[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedE[i],
              onChanged: (val) {
                setState(() {
                  _selectedE[i] = val;
                  print(val);
                  print(_selectedE[i]);
                  if (_selectedE[i]) {
                    _selectedEthnicities.add(_ethnicities[i]);
                  } else {
                    if (_selectedEthnicities.length != 1) {
                      _selectedEthnicities.remove(_ethnicities[i]);
                    } else
                      _selectedE[i] = true;
                  }
                  changed++;
                });
                print(_selectedEthnicities.join(", "));
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

  List<Widget> _buildReligions() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _religions.length; i++) {
      if (_selectedReligions.contains(_religions[i])) {
        _selectedR[i] = true;
      } else
        _selectedR[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _religions[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedR[i],
              onChanged: (val) {
                setState(() {
                  _selectedR[i] = val;
                  print(val);
                  print(_selectedR[i]);
                  if (_selectedR[i]) {
                    _selectedReligions.add(_religions[i]);
                  } else {
                    if (_selectedReligions.length != 1) {
                      _selectedReligions.remove(_religions[i]);
                    } else
                      _selectedR[i] = true;
                  }
                  changed++;
                });
                print(_selectedReligions.join(", "));
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

  List<Widget> _buildSings() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _signs.length; i++) {
      if (_selectedSigns.contains(_signs[i])) {
        _selectedS[i] = true;
      } else
        _selectedS[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _signs[i],
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
                    _selectedSigns.add(_signs[i]);
                  } else {
                    if (_selectedSigns.length != 1) {
                      _selectedSigns.remove(_signs[i]);
                    } else
                      _selectedS[i] = true;
                  }
                  changed++;
                });
                print(_selectedSigns.join(", "));
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

  List<Widget> _buildPolitics() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _politics.length; i++) {
      if (_selectedPolitics.contains(_politics[i])) {
        _selectedP[i] = true;
      } else
        _selectedP[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _politics[i],
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
                    _selectedPolitics.add(_politics[i]);
                  } else {
                    if (_selectedPolitics.length != 1) {
                      _selectedPolitics.remove(_politics[i]);
                    } else
                      _selectedP[i] = true;
                  }
                  changed++;
                });
                print(_selectedPolitics.join(", "));
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

  List<Widget> _buildEmployments() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _employments.length; i++) {
      if (_selectedEmployments.contains(_employments[i])) {
        _selectedEm[i] = true;
      } else
        _selectedEm[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _employments[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedEm[i],
              onChanged: (val) {
                setState(() {
                  _selectedEm[i] = val;
                  print(val);
                  print(_selectedEm[i]);
                  if (_selectedEm[i]) {
                    _selectedEmployments.add(_employments[i]);
                  } else {
                    if (_selectedEmployments.length != 1) {
                      _selectedEmployments.remove(_employments[i]);
                    } else
                      _selectedEm[i] = true;
                  }
                  changed++;
                });
                print(_selectedEmployments.join(", "));
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

  List<Widget> _buildEducations() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _educations.length; i++) {
      if (_selectedEducations.contains(_educations[i])) {
        _selectedEd[i] = true;
      } else
        _selectedEd[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _educations[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedEd[i],
              onChanged: (val) {
                setState(() {
                  _selectedEd[i] = val;
                  print(val);
                  print(_selectedEd[i]);
                  if (_selectedEd[i]) {
                    _selectedEducations.add(_educations[i]);
                  } else {
                    if (_selectedEducations.length != 1) {
                      _selectedEducations.remove(_educations[i]);
                    } else
                      _selectedEd[i] = true;
                  }
                  changed++;
                });
                print(_selectedEducations.join(", "));
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

  List<Widget> _buildLangues() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _langues.length; i++) {
      if (_selectedLangues.contains(_langues[i])) {
        _selectedL[i] = true;
      } else
        _selectedL[i] = false;
      list.add(
        Row(
          children: <Widget>[
            Text(
              _langues[i],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Checkbox(
              value: _selectedL[i],
              onChanged: (val) {
                setState(() {
                  _selectedL[i] = val;
                  print(val);
                  print(_selectedL[i]);
                  if (_selectedL[i]) {
                    _selectedLangues.add(_langues[i]);
                  } else {
                    if (_selectedLangues.length != 1) {
                      _selectedLangues.remove(_langues[i]);
                    } else
                      _selectedL[i] = true;
                  }
                  changed++;
                });
                print(_selectedLangues.join(", "));
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
    idealPerson.ethnicities = _selectedEthnicities;
    idealPerson.religions = _selectedReligions;
    idealPerson.signs = _selectedSigns;
    idealPerson.politics = _selectedPolitics;
    idealPerson.employments = _selectedEmployments;
    idealPerson.educations = _selectedEducations;
    idealPerson.langues = _selectedLangues;
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
      "ethnicities": idealPerson.ethnicities,
      "religions": idealPerson.religions,
      "signs": idealPerson.signs,
      "politics": idealPerson.politics,
      "employments": idealPerson.employments,
      "educations": idealPerson.educations,
      "langues": idealPerson.langues,
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
    _selectedEthnicities = idealPerson.ethnicities;
    _selectedReligions = idealPerson.religions;
    _selectedSigns = idealPerson.signs;
    _selectedPolitics = idealPerson.politics;
    _selectedEmployments = idealPerson.employments;
    _selectedEducations = idealPerson.educations;
    _selectedLangues = idealPerson.langues;
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
          "Background Preferences",
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
                    "ETHNICITY :",
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
                      _selectedEthnicities.length == _ethnicities.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedEthnicities[0]}...",
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
                          children: _buildEthnicities(),
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
                    "RELIGION :",
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
                      _selectedReligions.length == _religions.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedReligions[0]}...",
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
                          children: _buildReligions(),
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
                    "SIGN :",
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
                      _selectedSigns.length == _signs.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedSigns[0]}...",
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
                          children: _buildSings(),
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
                    "POLITIC :",
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
                      _selectedPolitics.length == _politics.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedPolitics[0]}...",
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
                          children: _buildPolitics(),
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
                    "EMPLOYEMENT :",
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
                      _selectedEmployments.length == _employments.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedEmployments[0]}...",
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
                          children: _buildEmployments(),
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
                    "EDUCATION :",
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
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedEducations.length == _educations.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedEducations[0]}...",
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
                          children: _buildEducations(),
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
                    "SPEAKS :",
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
                      visible[6] = !visible[6];
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _selectedLangues.length == _langues.length
                          ? Text(
                              "Open to any",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600]),
                            )
                          : Text(
                              "${_selectedLangues[0]}...",
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
                visible: visible[6],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: _width * 0.85,
                    child: Card(
                      elevation: 13,
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          children: _buildLangues(),
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
