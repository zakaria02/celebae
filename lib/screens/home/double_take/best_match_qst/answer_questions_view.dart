import 'package:auto_size_text/auto_size_text.dart';
import '../../../../model/profile.dart';
import '../../../../model/bestMatch.dart';
import 'qst1_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnswerQuestionsView extends StatelessWidget {
  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  List<BestMatchQuestion> listBestMatchQuestion = new List<BestMatchQuestion>();
  Profile profile;
  AnswerQuestionsView({this.profile});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
          alignment: Alignment.center,
          child: Card(
            elevation: 13,
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: _width,
                  ),
                  AutoSizeText(
                    "Answer questions to\ncalculate your best\nmatches.",
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 27,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Image.asset("assets/images/interest_image.png"),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Container(
                    width: _width * 0.5,
                    height: 45,
                    child: RaisedButton(
                      color: primaryColor,
                      child: Text(
                        "ANSWER",
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Question1View(
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
          ),
        ),
      ),
    );
  }
}
