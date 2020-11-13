import 'package:auto_size_text/auto_size_text.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';
import '../../../../model/bestMatch.dart';
import 'qst10_view.dart';

class Question9View extends StatefulWidget {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  Question9View({this.profile, this.listBestMatchQuestion});
  @override
  State<StatefulWidget> createState() {
    return _Question9ViewState(
      profile: profile,
      listBestMatchQuestion: listBestMatchQuestion,
    );
  }
}

enum SingingCharacter { yes, no }

class _Question9ViewState extends State<Question9View> {
  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  _Question9ViewState({this.profile, this.listBestMatchQuestion});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  String _myAnswer = "";
  List<String> _answers = new List<String>();
  SingingCharacter sc;
  bool _answered = false, _yes = false, _no = false;

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
                padding: EdgeInsets.all(40),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Could you date someone who was really messy?",
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
                                "Yes",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.yes,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "Yes";
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
                                "No",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Radio(
                                activeColor: primaryColor,
                                value: SingingCharacter.no,
                                groupValue: sc,
                                onChanged: (value) {
                                  setState(() {
                                    sc = value;
                                    _myAnswer = "No";
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
                      "Could you date someone who was really messy?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
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
                      height: _height * 0.01,
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
                                "Yes",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _yes,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _yes = value;
                                    changed++;
                                    if (_yes)
                                      _answers.add("Yes");
                                    else
                                      _answers.remove("Yes");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
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
                                "No",
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: _no,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _no = value;
                                    changed++;
                                    if (_no)
                                      _answers.add("No");
                                    else
                                      _answers.remove("No");
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
                                  "Could you date someone who was really messy?",
                              answer: _myAnswer,
                              idealPersonAnswers: _answers,
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Question10View(
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
                                "Could you date someone who was really messy?",
                            answer: "",
                            idealPersonAnswers: new List<String>(),
                          ),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Question10View(
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
