import 'ideal_person/family_view.dart';
import 'ideal_person/life_style_view.dart';
import '../../../screens/home/profile/ideal_person/background_view.dart';
import '../../../screens/home/profile/ideal_person/looks_view.dart';
import '../../../model/idealPerson.dart';
import 'ideal_person/basics_view.dart';
import '../../../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/profile.dart';
import 'package:flutter/material.dart';

class IdealPersonView extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  IdealPersonView({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _IdealPersonViewState(profile: profile, idealPerson: idealPerson);
  }
}

class _IdealPersonViewState extends State<IdealPersonView> {
  Profile profile;
  IdealPerson idealPerson;
  final Color primaryColor = Color(0xFFff0e55);
  double _height = 0, _width = 0;
  String idealPersonUID;
  _IdealPersonViewState({this.profile, this.idealPerson});

  getIdealPersonDocumentUID() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('idealPerson')
        .snapshots()
        .listen((event) {
      idealPersonUID = event.documents.elementAt(0).documentID;
      print("ideal person : $idealPersonUID");
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    getIdealPersonDocumentUID();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "My ideal person",
          style: TextStyle(
              fontFamily: "Poppins", color: Colors.white, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.1,
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.category),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "BASICS",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => BasicsViewIdeal(
                            profile: profile,
                            idealPerson: idealPerson,
                            source: idealPersonUID,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.accessibility_new),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "LOOKS",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LooksView(
                            profile: profile,
                            idealPerson: idealPerson,
                            source: idealPersonUID,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.recent_actors),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "BACKGROUND PREFERENCES",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => BackgroundView(
                            profile: profile,
                            idealPerson: idealPerson,
                            source: idealPersonUID,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.local_bar),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "LIFESTYLE",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LifeStyleView(
                            profile: profile,
                            idealPerson: idealPerson,
                            source: idealPersonUID,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.child_friendly),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "FAMILY",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => FamilyView(
                            profile: profile,
                            idealPerson: idealPerson,
                            source: idealPersonUID,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}
