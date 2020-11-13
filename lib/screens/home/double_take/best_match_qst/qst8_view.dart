import 'package:auto_size_text/auto_size_text.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';
import '../../../../model/bestMatch.dart';
import 'qst9_view.dart';

class Question8View extends StatefulWidget {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  Question8View({
    this.profile,
    this.listBestMatchQuestion,
  });
  @override
  State<StatefulWidget> createState() {
    return _Question8ViewState(
      profile: profile,
      listBestMatchQuestion: listBestMatchQuestion,
    );
  }
}

enum SingingCharacter {
  liberalLeft,
  centrist,
  conservativeRight,
  other,
}

class _Question8ViewState extends State<Question8View> {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  _Question8ViewState({this.profile, this.listBestMatchQuestion});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  String _myAnswer = "";
  List<String> _answers = new List<String>();
  SingingCharacter sc;
  bool _answered = false,
      _liberalLeft = false,
      _centrist = false,
      _conservativeRight = false,
      _other = false;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/app_bar_2.png",
                ),
                Padding(
                  padding: EdgeInsets.only(top: _height * 0.04),
                  child: MaterialButton(
                      child: Text(
                        "<",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w800,
                          fontSize: 33,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: _height * 0.05),
                      child: Text(
                        "Celebae",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 27),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            Visibility(
              visible: !_answered,
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Which best describes yout political beliefs?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Liberal/ Left",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.liberalLeft,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Liberal/ Left";
                                    changed++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Centrist",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.centrist,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Centrist";
                                    changed++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Conservative/ Right",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.conservativeRight,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Conservative/ Right";
                                    changed++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Other",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.other,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Other";
                                    changed++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _answered,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Which best describes your political beliefs?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: _width * 0.5,
                          height: 47,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            color: primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: AutoSizeText(
                                _myAnswer,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.network(
                                    profile.profileImageUrl,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(4.0), // borde width
                            decoration: new BoxDecoration(
                              color: primaryColor, // border color
                              shape: BoxShape.circle,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          "Your ideal person would say:",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Liberal/ Left",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _liberalLeft,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _liberalLeft = value;
                                    if (_liberalLeft)
                                      _answers.add("Liberal/ Left");
                                    else
                                      _answers.remove("Liberal/ Left");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Centrist",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _centrist,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _centrist = value;
                                    if (_centrist)
                                      _answers.add("Centrist");
                                    else
                                      _answers.remove("Centrist");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Conservative/ Right",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _conservativeRight,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _conservativeRight = value;
                                    if (_conservativeRight)
                                      _answers.add("Conservative/ Right");
                                    else
                                      _answers.remove("Conservative/ Right");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width,
                      height: 65,
                      child: Card(
                        elevation: 13,
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                "Other",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _other,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _other = value;
                                    if (_other)
                                      _answers.add("Other");
                                    else
                                      _answers.remove("Other");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Container(
                    width: _width,
                    height: 47,
                    child: RaisedButton(
                      color: primaryColor,
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 18),
                      ),
                      onPressed: () {
                        if (changed > 0 && _myAnswer != "") {
                          setState(() {
                            _answered = true;
                          });
                        }
                        if (_answered && changed > 0 && _answers.length > 0) {
                          listBestMatchQuestion.add(
                            BestMatchQuestion(
                              question:
                                  "Which best describes yout political beliefs?",
                              answer: _myAnswer,
                              idealPersonAnswers: _answers,
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Question9View(
                                profile: profile,
                                listBestMatchQuestion: listBestMatchQuestion,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: _width,
                    height: 47,
                    child: MaterialButton(
                      child: Text(
                        "Skip the question!",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontSize: 18),
                      ),
                      onPressed: () {
                        listBestMatchQuestion.add(
                          BestMatchQuestion(
                            question:
                                "Which best describes yout political beliefs?",
                            answer: "",
                            idealPersonAnswers: new List<String>(),
                          ),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Question9View(
                              profile: profile,
                              listBestMatchQuestion: listBestMatchQuestion,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
