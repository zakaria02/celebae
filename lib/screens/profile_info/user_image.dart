import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../model/profile.dart';
import '../../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'user_description_view.dart';

class UserImages extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  String source;
  UserImages({this.profile, this.idealPerson, this.source});
  @override
  State<StatefulWidget> createState() {
    return _UserImagesState(
        profile: profile, idealPerson: idealPerson, source: source);
  }
}

class _UserImagesState extends State<UserImages> with TickerProviderStateMixin {
  final Color primaryColor = Color(0xFFff0e55);
  final db = Firestore.instance;
  bool _err = false, _state = false, _err1 = false;
  File _image;
  int added = 0;
  double _height = 0, _width = 0;
  List<File> listImages = new List<File>(8);
  List<File> images = new List<File>();
  Profile profile;
  IdealPerson idealPerson;
  String source;
  _UserImagesState({this.profile, this.idealPerson, this.source});
  List list = new List();

  Future getImageGallery(int index) async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = _imageFile;
      listImages[index] = _image;
      added++;
    });
    if (_image != null) {
      Navigator.of(context).pop();
    }
  }

  Future getImageCamera(int index) async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = _imageFile;
      listImages[index] = _image;
      added++;
    });
    if (_image != null) {
      Navigator.of(context).pop();
    }
  }

  showAlertImage(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Camera", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        getImageCamera(index);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Gallery", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        getImageGallery(index);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "Add picture from : ",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // build grid edit pictures
  List<Padding> gridViewEdit() {
    List<Padding> list = new List<Padding>();
    int length = 7 - profile.picturesUrl.length;
    for (int i = 0; i < length; i++) {
      list.add(Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: listImages[i] == null
              ? Image.asset(
                  "assets/images/upload_image.png",
                  height: _height * 0.15,
                  width: _height * 0.15,
                )
              : Image.file(
                  listImages[i],
                  height: _height * 0.15,
                  width: _height * 0.15,
                ),
          onTap: () {
            showAlertImage(context, i);
          },
        ),
      ));
    }
    return list;
  }
  // build grid add pictures

  List<Padding> gridViewAdd() {
    List<Padding> list = new List<Padding>();
    for (int i = 0; i < 8; i++) {
      list.add(Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: listImages[i] == null
              ? Image.asset(
                  "assets/images/upload_image.png",
                  height: _height * 0.15,
                  width: _height * 0.15,
                )
              : Image.file(
                  listImages[i],
                  height: _height * 0.15,
                  width: _height * 0.15,
                ),
          onTap: () {
            showAlertImage(context, i);
          },
        ),
      ));
    }
    return list;
  }

  void uploadImages(_img, index) async {
    if (!_state) animateButton();
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
      if (index == images.length - 1) {
        for (int i = 0; i < list.length; i++) {
          if (list[i] != null) profile.picturesUrl.add(list[i]);
        }
        for (int i = 0; i < list.length; i++) {
          print("List Url ${i + 1} ${list[i]}");
        }
        for (int i = 0; i < profile.picturesUrl.length; i++) {
          print("File Url ${i + 1} ${profile.picturesUrl[i]}");
        }
        updateDataBase(uid, source);
      }
    }
  }

  updateDataBase(uid, source) async {
    await db
        .collection("userData")
        .document(uid)
        .collection("profile")
        .document(source)
        .updateData({'images': profile.picturesUrl}).then((value) {
      setState(() {
        _state = false;
      });
      Navigator.of(context).pop();
    });
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
        "UPLOAD PICTURES",
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

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                  height: _height * 0.01,
                ),
                AutoSizeText(
                  "Add some great photos",
                  style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            delegate: SliverChildListDelegate(
              source != null ? gridViewEdit() : gridViewAdd(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: _height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Visibility(
                  visible: _err,
                  child: ErrorMessage(text: "Please upload the first image !"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Visibility(
                  visible: _err1,
                  child: ErrorMessage(text: "Upload at least one picture !"),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Visibility(
                visible: source == null,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: _width * 0.7,
                  height: _height * 0.07,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: primaryColor)),
                      color: primaryColor,
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 18),
                      ),
                      onPressed: () {
                        if (listImages[0] == null) {
                          setState(() {
                            _err = true;
                          });
                        } else {
                          setState(() {
                            _err = false;
                            for (int i = 0; i < 8; i++) {
                              if (listImages[i] != null) {
                                images.add(listImages[i]);
                              }
                            }
                            profile.pictures = images;
                            profile.picturesUrl = new List<String>();
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserDescription(
                                      profile: profile,
                                      idealPerson: idealPerson,
                                    )),
                          );
                        }
                      }),
                ),
              ),
              Visibility(
                visible: source != null,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: _width * 0.7,
                  height: _height * 0.07,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: primaryColor)),
                      color: primaryColor,
                      child: _builButtonChild(),
                      onPressed: !_state
                          ? () {
                              print(added);
                              if (added == 0) {
                                setState(() {
                                  _err1 = true;
                                });
                              } else {
                                setState(() {
                                  _err = false;
                                  for (int i = 0; i < 8; i++) {
                                    if (listImages[i] != null) {
                                      images.add(listImages[i]);
                                    }
                                  }
                                });
                                for (int i = 0; i < images.length; i++) {
                                  uploadImages(images[i], i);
                                }
                              }
                            }
                          : null),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
