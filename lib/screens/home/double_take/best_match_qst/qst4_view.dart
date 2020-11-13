import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebae/model/profile.dart';
import 'package:flutter/material.dart';
import '../../../../model/bestMatch.dart';
import 'qst5_view.dart';

class Question4View extends StatefulWidget {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  Question4View({this.profile, this.listBestMatchQuestion});
  @override
  State<StatefulWidget> createState() {
    return _Question4ViewState(
      profile: profile,
      listBestMatchQuestion: listBestMatchQuestion,
    );
  }
}

enum SingingCharacter {
  absolutely,
  noWay,
  getMarriedYesSettleDownNo,
  getMarriedNoSettleDownYes
}

class _Question4ViewState extends State<Question4View> {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  _Question4ViewState({this.profile, this.listBestMatchQuestion});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  String _myAnswer = "";
  List<String> _answers = new List<String>();
  SingingCharacter sc;
  bool _answered = false,
      _absolutely = false,
      _noWay = false,
      _getMarriedYesSettleDownNo = false,
      _getMarriedNoSettleDownYes = false;

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
                      "Are you ready to settle down and get married right now?",
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
                                "Absolutely",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.absolutely,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Absolutely";
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
                                "No way",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.noWay,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "No way";
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
                                "Get married yes, settle down no",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value:
                                    SingingCharacter.getMarriedYesSettleDownNo,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer =
                                        "Get married yes, settle down no";
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
                                "Get married no, settle down yes",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value:
                                    SingingCharacter.getMarriedNoSettleDownYes,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer =
                                        "Get married no, settle down yes";
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
                      "Are you ready to settle down and get married right now?",
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
                                "Absolutely",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _absolutely,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _absolutely = value;
                                    if (_absolutely)
                                      _answers.add("Absolutely");
                                    else
                                      _answers.remove("Absolutely");
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
                                "No way",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _noWay,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _noWay = value;
                                    if (_noWay)
                                      _answers.add("No way");
                                    else
                                      _answers.remove("No way");
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
                                "Get married yes, settle down no",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _getMarriedYesSettleDownNo,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _getMarriedYesSettleDownNo = value;
                                    if (_getMarriedYesSettleDownNo)
                                      _answers.add(
                                          "Get married yes, settle down no");
                                    else
                                      _answers.remove(
                                          "Get married yes, settle down no");
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
                                "Get married no, settle down yes",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _getMarriedNoSettleDownYes,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _getMarriedNoSettleDownYes = value;
                                    if (_getMarriedNoSettleDownYes)
                                      _answers.add(
                                          "Get married no, settle down yes");
                                    else
                                      _answers.remove(
                                          "Get married no, settle down yes");
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
                          listBestMatchQuestion.add(BestMatchQuestion(
                            question:
                                "Are you ready to settle down and get married right now?",
                            answer: _myAnswer,
                            idealPersonAnswers: _answers,
                          ));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Question5View(
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
                        listBestMatchQuestion.add(BestMatchQuestion(
                          question:
                              "Are you ready to settle down and get married right now?",
                          answer: "",
                          idealPersonAnswers: new List<String>(),
                        ));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Question5View(
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
