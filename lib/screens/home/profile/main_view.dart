import 'dart:io';
import '../../../model/idealPerson.dart';
import '../../../model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/CircularProgressWidget.dart';
import '../../../widgets/provider_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../../../model/profile.dart';
import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'ideal_person.dart';
import 'settings_view.dart';

class ProfileView extends StatelessWidget {
  Profile profile = new Profile(picturesUrl: new List<String>());
  IdealPerson idealPerson = new IdealPerson();
  Stream<QuerySnapshot> getUserProfileStreamSnapchots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    profile.uid = uid;
    yield* Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .snapshots();
  }

  Stream<QuerySnapshot> getUserIdealPersonStreamSnapchots(
      BuildContext context) async* {
    yield* Firestore.instance
        .collection("userData")
        .document(profile.uid)
        .collection('idealPerson')
        .snapshots();
  }

  StreamBuilder getProfile(BuildContext context) {
    return StreamBuilder(
      stream: getUserProfileStreamSnapchots(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          profile.birthday = snapshot.data.documents[0]['birthday'].toDate();
          profile.age =
              (DateTime.now().difference(profile.birthday).inDays / 365)
                  .round();
          profile.country = snapshot.data.documents[0]['country'];
          profile.city = snapshot.data.documents[0]['city'];
          profile.gender = snapshot.data.documents[0]['gender'];
          profile.pronoun = snapshot.data.documents[0]['pronoun'];
          profile.bodyType = snapshot.data.documents[0]['bodyType'];
          profile.heightUnite = snapshot.data.documents[0]['heightUnite'];
          profile.height = snapshot.data.documents[0]['height'].toDouble();
          profile.ethnicity = snapshot.data.documents[0]['ethnicity'];
          profile.religion = snapshot.data.documents[0]['religion'];
          profile.sign = snapshot.data.documents[0]['sign'];
          profile.politic = snapshot.data.documents[0]['politic'];
          profile.employement = snapshot.data.documents[0]['employement'];
          profile.education = snapshot.data.documents[0]['education'];
          profile.langue = snapshot.data.documents[0]['langue'];
          profile.diet = snapshot.data.documents[0]['diet'];
          profile.smoking = snapshot.data.documents[0]['smoking'];
          profile.drinking = snapshot.data.documents[0]['drinking'];
          profile.marijuana = snapshot.data.documents[0]['marijuana'];
          profile.hasKids = snapshot.data.documents[0]['hasKids'];
          profile.wantKids = snapshot.data.documents[0]['wantKids'];
          profile.pet = snapshot.data.documents[0]['pet'];
          profile.relationship = snapshot.data.documents[0]['relationship'];
          profile.interestConnections =
              snapshot.data.documents[0]['interestConnections'];
          profile.lat = snapshot.data.documents[0]['latitude'];
          profile.long = snapshot.data.documents[0]['longitude'];
          profile.profileImageUrl =
              snapshot.data.documents[0]['profileImageUrl'];
          profile.orientation = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['orientation'].length;
              i++) {
            profile.orientation
                .add(snapshot.data.documents[0]['orientation'][i]);
          }
          profile.picturesUrl.clear();
          for (int i = 0;
              i < snapshot.data.documents[0]['images'].length;
              i++) {
            profile.picturesUrl.add(snapshot.data.documents[0]['images'][i]);
          }
          profile.listQuestion = new List<Question>();
          for (int i = 0;
              i < snapshot.data.documents[0]['questions'].length;
              i++) {
            profile.listQuestion.add(new Question(
                question: snapshot.data.documents[0]['questions'][i]
                    ['question'],
                answer: snapshot.data.documents[0]['questions'][i]['answer']));
          }
          return getIdealPerson(context);
        } else
          return CircularProgressWidget();
      },
    );
  }

  StreamBuilder getIdealPerson(BuildContext context) {
    return StreamBuilder(
      stream: getUserIdealPersonStreamSnapchots(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          idealPerson.genders = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['genders'].length;
              i++) {
            idealPerson.genders.add(snapshot.data.documents[0]['genders'][i]);
          }
          idealPerson.orientations = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['orientations'].length;
              i++) {
            idealPerson.orientations
                .add(snapshot.data.documents[0]['orientations'][i]);
          }
          idealPerson.distance = snapshot.data.documents[0]['distance'];
          idealPerson.minAge = snapshot.data.documents[0]['minAge'];
          idealPerson.maxAge = snapshot.data.documents[0]['maxAge'];
          idealPerson.connections = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['connections'].length;
              i++) {
            idealPerson.connections
                .add(snapshot.data.documents[0]['connections'][i]);
          }
          idealPerson.status = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['status'].length;
              i++) {
            idealPerson.status.add(snapshot.data.documents[0]['status'][i]);
          }
          idealPerson.bodyTypes = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['bodyTypes'].length;
              i++) {
            idealPerson.bodyTypes
                .add(snapshot.data.documents[0]['bodyTypes'][i]);
          }
          idealPerson.minHeight = snapshot.data.documents[0]['minHeight'];
          idealPerson.maxHeight = snapshot.data.documents[0]['maxHeight'];
          idealPerson.ethnicities = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['ethnicities'].length;
              i++) {
            idealPerson.ethnicities
                .add(snapshot.data.documents[0]['ethnicities'][i]);
          }
          idealPerson.religions = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['religions'].length;
              i++) {
            idealPerson.religions
                .add(snapshot.data.documents[0]['religions'][i]);
          }
          idealPerson.signs = new List<String>();
          for (int i = 0; i < snapshot.data.documents[0]['signs'].length; i++) {
            idealPerson.signs.add(snapshot.data.documents[0]['signs'][i]);
          }
          idealPerson.politics = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['politics'].length;
              i++) {
            idealPerson.politics.add(snapshot.data.documents[0]['politics'][i]);
          }
          idealPerson.employments = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['employments'].length;
              i++) {
            idealPerson.employments
                .add(snapshot.data.documents[0]['employments'][i]);
          }
          idealPerson.educations = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['educations'].length;
              i++) {
            idealPerson.educations
                .add(snapshot.data.documents[0]['educations'][i]);
          }
          idealPerson.langues = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['langues'].length;
              i++) {
            idealPerson.langues.add(snapshot.data.documents[0]['langues'][i]);
          }
          idealPerson.alcohol = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['alcohol'].length;
              i++) {
            idealPerson.alcohol.add(snapshot.data.documents[0]['alcohol'][i]);
          }
          idealPerson.smoking = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['smoking'].length;
              i++) {
            idealPerson.smoking.add(snapshot.data.documents[0]['smoking'][i]);
          }
          idealPerson.marijuana = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['marijuana'].length;
              i++) {
            idealPerson.marijuana
                .add(snapshot.data.documents[0]['marijuana'][i]);
          }
          idealPerson.diets = new List<String>();
          for (int i = 0; i < snapshot.data.documents[0]['diets'].length; i++) {
            idealPerson.diets.add(snapshot.data.documents[0]['diets'][i]);
          }
          idealPerson.pets = new List<String>();
          for (int i = 0; i < snapshot.data.documents[0]['pets'].length; i++) {
            idealPerson.pets.add(snapshot.data.documents[0]['pets'][i]);
          }
          idealPerson.hasKids = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['hasKids'].length;
              i++) {
            idealPerson.hasKids.add(snapshot.data.documents[0]['hasKids'][i]);
          }
          idealPerson.wantKids = new List<String>();
          for (int i = 0;
              i < snapshot.data.documents[0]['wantKids'].length;
              i++) {
            idealPerson.wantKids.add(snapshot.data.documents[0]['wantKids'][i]);
          }
          return ProfileUploaded(
            profile: profile,
            idealPerson: idealPerson,
          );
        } else
          return CircularProgressWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of(context).auth.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            profile.name = snapshot.data.displayName;
            profile.email = snapshot.data.email;
            return getProfile(context);
          } else
            return CircularProgressWidget();
        },
      ),
    );
  }
}

class ProfileUploaded extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  ProfileUploaded({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _ProfileUploadedState(profile: profile, idealPerson: idealPerson);
  }
}

class _ProfileUploadedState extends State<ProfileUploaded> {
  final Color primaryColor = Color(0xFFff0e55);
  Profile profile;
  IdealPerson idealPerson;
  _ProfileUploadedState({this.profile, this.idealPerson});
  File _image;
  bool _uploading = false;
  String profileUID, idealPersonUID;
  Future getImageGallery() async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = _imageFile;
      if (_image != null) uploadFile(_image);
    });
    if (_image != null) {
      Navigator.of(context).pop();
    }
  }

  Future getImageCamera() async {
    var _imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = _imageFile;
      if (_image != null) uploadFile(_image);
    });
    if (_image != null) {
      Navigator.of(context).pop();
    }
  }

  showAlertImage(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Camera", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        getImageCamera();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Gallery", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        getImageGallery();
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

  getProfileDocumentUID() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .snapshots()
        .listen((event) {
      profileUID = event.documents.elementAt(0).documentID;
      print("profile : $profileUID");
    });
  }

  updateProfilePicture(uid, url) async {
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .document(profileUID)
        .updateData({"profileImageUrl": url}).then((value) {
      print("Image Url Updated");
    });
  }

  Future uploadFile(File _img) async {
    setState(() {
      _uploading = true;
    });
    final uid = await Provider.of(context).auth.getCurrentUID();
    int index = Path.basename(_img.path).indexOf(".");
    String ext = Path.basename(_img.path).substring(index);
    String imageName = "profile" + ext;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('$uid/$imageName');
    StorageUploadTask uploadTask = storageReference.putFile(_img);
    await uploadTask.onComplete;
    setState(() {
      _uploading = false;
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
    });
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        profile.profileImageUrl = fileURL;
        updateProfilePicture(uid, fileURL);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getProfileDocumentUID();
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset("assets/images/app_bar_2.png"),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: _uploading
                                    ? CircularProgressWidget()
                                    : profile.profileImageUrl == null
                                        ? Icon(
                                            Icons.person,
                                            color: Colors.grey[700],
                                            size: 180,
                                          )
                                        : Image.network(
                                            profile.profileImageUrl,
                                            height: 180,
                                            width: 180,
                                          ),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(4.0), // borde width
                          decoration: new BoxDecoration(
                            color: Colors.black, // border color
                            shape: BoxShape.circle,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: IconButton(
                          icon: Icon(
                            Icons.photo_camera,
                            color: primaryColor,
                          ),
                          iconSize: 30.0,
                          onPressed: () {
                            showAlertImage(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Text(
              profile.name + ", " + profile.age.toString(),
              style: TextStyle(fontFamily: "Poppins", fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              profile.country + ", " + profile.city,
              style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.1,
            ),
            Container(
              width: _width * 0.7,
              height: _height * 0.08,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: primaryColor, width: 2)),
                  color: Colors.white,
                  child: Text(
                    "MY PROFILE",
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  splashColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditProfile(
                                profile: profile,
                                idealPerson: idealPerson,
                              )),
                    );
                  }),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Container(
              width: _width * 0.7,
              height: _height * 0.08,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: primaryColor, width: 2)),
                  color: Colors.white,
                  child: Text(
                    "MY IDEAL PERSON",
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  splashColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => IdealPersonView(
                                profile: profile,
                                idealPerson: idealPerson,
                              )),
                    );
                  }),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Container(
              width: _width * 0.7,
              height: _height * 0.08,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: primaryColor, width: 2)),
                  color: Colors.white,
                  child: Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  splashColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SettingsView(
                                profile: profile,
                              )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
