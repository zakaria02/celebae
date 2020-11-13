import '../model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomDialog extends StatelessWidget {
  Profile profile;
  int index;
  String source, _answer;
  CustomDialog({
    @required this.profile,
    @required this.index,
    @required this.source,
  });

  static const double padding = 20.0;
  final Color primaryColor = Colors.white;
  final Color secondaryColor = Color(0xFFff0e55);

  updateData(uid) async {
    if (_answer != null) profile.listQuestion[index].answer = _answer;
    print(profile.questionToString());
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .document(source)
        .updateData({
      "questions": [
        for (int i = 0; i < profile.listQuestion.length; i++)
          profile.listQuestion[i].toJson(),
      ]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                AutoSizeText(
                  profile.listQuestion[index].question,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  controller: TextEditingController(
                      text: profile.listQuestion[index].answer),
                  maxLines: 7,
                  onChanged: (value) {
                    _answer = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                RaisedButton(
                  color: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AutoSizeText(
                    "SAVE",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    updateData(profile.uid).then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
                FlatButton(
                  child: AutoSizeText(
                    "CANCEL",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
