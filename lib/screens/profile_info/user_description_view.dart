import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../widgets/provider_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;

class UserDescription extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  UserDescription({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _UserDescriptionState(profile: profile, idealPerson: idealPerson);
  }
}

class _UserDescriptionState extends State<UserDescription>
    with TickerProviderStateMixin {
  Profile profile;
  IdealPerson idealPerson;
  _UserDescriptionState({this.profile, this.idealPerson});

  final Color primaryColor = Color(0xFFff0e55);
  final formKey = new GlobalKey<FormState>();
  String _description;
  bool _state = false;
  List list = new List();
  final db = Firestore.instance;

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
        "NEXT",
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

  void insertIdealPerson(uid) async {
    await db
        .collection("userData")
        .document(uid)
        .collection("idealPerson")
        .add(idealPerson.toJson())
        .then((value) {
      print("Ideal person Inserted");
      setState(() {
        _state = false;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  void insertProfile(uid) async {
    print("Profile Url : " + profile.profileImageUrl);
    await db
        .collection("userData")
        .document(uid)
        .collection("profile")
        .add(profile.toJson())
        .then((value) {
      print("Profile Inserted");
      insertIdealPerson(uid);
    });
  }

  void uploadImages(_img, index) async {
    if (_img != null) {
      final uid = await Provider.of(context).auth.getCurrentUID();
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('$uid/images/${Path.basename(_img.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(_img);
      StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      if (uploadTask.isComplete) {
        list.add(downloadUrl.toString());
        print(list.length);
      }
      if (index == profile.pictures.length - 1) {
        for (int i = 0; i < list.length; i++) {
          if (list[i] != null) profile.picturesUrl.add(list[i]);
        }
        for (int i = 0; i < profile.picturesUrl.length; i++) {
          print("File Url ${i + 1} ${profile.picturesUrl[i]}");
        }
        insertProfile(uid);
      }
    }
  }

  void _validateInputs() async {
    list = new List();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (!_state) animateButton();
      final uid = await Provider.of(context).auth.getCurrentUID();
      int index = Path.basename(profile.pictures[0].path).indexOf(".");
      String ext = Path.basename(profile.pictures[0].path).substring(index);
      String imageName = "profile" + ext;
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('$uid/$imageName');
      StorageUploadTask uploadTask =
          storageReference.putFile(profile.pictures[0]);
      await uploadTask.onComplete.then((value) {
        print("Image Uploaded");
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            print("File Url : $fileURL");
            profile.profileImageUrl = fileURL;
            profile.listQuestion[0].answer = _description;
          });
          if (profile.pictures.length > 1) {
            for (int i = 1; i < profile.pictures.length; i++) {
              uploadImages(profile.pictures[i], i);
            }
          } else
            insertProfile(uid);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
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
                            "About you",
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
                  height: _height * 0.04,
                ),
                AutoSizeText(
                  "Introduce Yourself with a short summary !",
                  style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                      style: TextStyle(fontSize: 22),
                      onSaved: (value) => _description = value,
                      decoration: InputDecoration(
                        hintText: 'Tell us about you',
                        filled: true,
                        fillColor: Colors.transparent,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 1.0),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 10.0, bottom: 10.0, top: 10.0),
                      ),
                      maxLines: 7,
                      validator: (value) {
                        if (value.isEmpty) return 'This field is obligatory!';
                        return null;
                      }),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                Container(
                    width: _width * 0.7,
                    height: _height * 0.07,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: primaryColor)),
                      color: primaryColor,
                      child: _builButtonChild(),
                      onPressed: !_state ? _validateInputs : null,
                    )),
              ],
            ),
          ),
        ));
  }
}
