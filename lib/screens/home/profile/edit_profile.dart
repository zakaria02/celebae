import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../../model/idealPerson.dart';
import 'ideal_person.dart';
import '../../../widgets/costum_dialog_widget.dart';
import '../../../screens/home/profile/edit_profile/children_pets_view.dart';
import '../../../screens/home/profile/edit_profile/smoking_drinking_view.dart';
import '../../../screens/home/profile/edit_profile/about_you_view.dart';
import '../../../screens/home/profile/edit_profile/bodyType_height_view.dart';
import '../../../screens/home/profile/edit_profile/gender_orientation_relationship.dart';
import '../../../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screens/profile_info/user_image.dart';
import '../../../model/profile.dart';
import 'package:flutter/material.dart';
import 'edit_profile/basics_view.dart';
import 'edit_profile/pronounview.dart';

class EditProfile extends StatefulWidget {
  Profile profile;
  IdealPerson idealPerson;
  EditProfile({this.profile, this.idealPerson});
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState(profile: profile, idealPerson: idealPerson);
  }
}

class _EditProfileState extends State<EditProfile> {
  Profile profile;
  IdealPerson idealPerson;
  final Color primaryColor = Color(0xFFff0e55);
  double _height = 0, _width = 0;
  String documentUID;
  _EditProfileState({this.profile, this.idealPerson});
  List<Image> images = new List<Image>();
  Widget imagesCarousel() {
    return Stack(
      children: <Widget>[
        Container(
          height: 400.0,
          child: Carousel(
            boxFit: BoxFit.cover,
            images: images,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 10),
            dotSize: 4.0,
            indicatorBgPadding: 2.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: _height * 0.04),
          child: MaterialButton(
              child: Icon(
                Icons.cancel,
                size: 37,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: _width - 180,
            ),
            Container(
              width: 175,
              child: Padding(
                padding: EdgeInsets.only(top: 340),
                child: MaterialButton(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.add_box,
                          size: 37,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add Pictures",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserImages(
                                  profile: profile,
                                  source: documentUID,
                                )),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  addImages() {
    images.clear();
    images.add(Image.network(profile.profileImageUrl));
    for (int i = 0; i < profile.picturesUrl.length; i++)
      images.add(Image.network(profile.picturesUrl[i]));
  }

  getProfileDocumentUID() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .snapshots()
        .listen((event) {
      documentUID = event.documents.elementAt(0).documentID;
      print("$documentUID");
    });
  }

  List<Padding> buildQst() {
    List<Padding> list = new List<Padding>();
    for (int i = 0; i < profile.listQuestion.length; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: _height * 0.35,
            width: _width * 0.85,
            child: Card(
              elevation: 13,
              child: Padding(
                padding: EdgeInsets.all(17),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      profile.listQuestion[i].question,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[700],
                    ),
                    AutoSizeText(
                      profile.listQuestion[i].answer,
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.border_color,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                      profile: profile,
                                      index: i,
                                      source: documentUID,
                                    ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    addImages();
    getProfileDocumentUID();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            imagesCarousel(),
            SizedBox(
              height: _height * 0.001,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    profile.name,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 20),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${profile.age}, ${profile.city}",
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.edit,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => BasicsView(
                                  profile: profile,
                                  source: documentUID,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[700],
            ),
            MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.assignment_ind),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Text(
                    "${profile.gender}, ${profile.orientation.length > 1 ? profile.orientation[0] + "..." : profile.orientation[0]}, ${profile.relationship}",
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
                      builder: (BuildContext context) =>
                          GenderOriontationRelationship(
                            profile: profile,
                            source: documentUID,
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
                  Icon(Icons.face),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  profile.pronoun == null ||
                          profile.pronoun == "(leave this blank)"
                      ? Text(
                          "Add: Pronouns",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                              color: Colors.grey[600]),
                        )
                      : Text(
                          "${profile.pronoun}",
                          style:
                              TextStyle(fontFamily: "Quicksand", fontSize: 17),
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
                      builder: (BuildContext context) => PronounView(
                            profile: profile,
                            source: documentUID,
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
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        children: [
                          profile.bodyType != "(leave this blank)"
                              ? TextSpan(
                                  text: profile.bodyType,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              : TextSpan(
                                  text: "Add: body type",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                          profile.height != 0
                              ? TextSpan(
                                  text:
                                      "\n${profile.height} ${profile.heightUnite}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              : TextSpan(
                                  text: "\nAdd: height",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                        ]),
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
                      builder: (BuildContext context) => BodyTypeHeight(
                            profile: profile,
                            source: documentUID,
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
                  if (profile.ethnicity != ("(leave this blank)"))
                    Text(
                      "Ethnicity : ${profile.ethnicity}..",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                    )
                  else if (profile.religion != ("(leave this blank)"))
                    Text("Religion : ${profile.religion}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.sign != ("(leave this blank)"))
                    Text("Sign : ${profile.sign}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.politic != ("(leave this blank)"))
                    Text("Politic : ${profile.politic}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.employement != ("(leave this blank)"))
                    Text("Employement : ${profile.employement}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.education != ("(leave this blank)"))
                    Text("Education : ${profile.education}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.langue != ("(leave this blank)"))
                    Text("Speaks : ${profile.langue}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else
                    Text(
                      "Add: About you",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
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
                      builder: (BuildContext context) => AboutYou(
                            profile: profile,
                            source: documentUID,
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
                  Icon(Icons.smoking_rooms),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  if (profile.diet != ("(leave this blank)"))
                    Text(
                      "Diet : ${profile.diet}...",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
                    )
                  else if (profile.smoking != ("(leave this blank)"))
                    Text("Smoking : ${profile.smoking}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.drinking != ("(leave this blank)"))
                    Text("Drinking : ${profile.drinking}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else if (profile.marijuana != ("(leave this blank)"))
                    Text("Marijuana : ${profile.marijuana}...",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 17))
                  else
                    Text(
                      "Add: smoking, drinking ...",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
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
                      builder: (BuildContext context) => SmokingDrinking(
                            profile: profile,
                            source: documentUID,
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
                  Icon(Icons.home),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        children: [
                          profile.hasKids != "(leave this blank)" ||
                                  profile.wantKids != "(leave this blank)"
                              ? TextSpan(
                                  text:
                                      "Children: ${profile.hasKids != "(leave this blank)" ? profile.hasKids : ""} ${profile.wantKids != "(leave this blank)" && profile.hasKids == "(leave this blank)" ? profile.wantKids : ""}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              : TextSpan(
                                  text: "Add: children",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                          profile.pet != "(leave this blank)"
                              ? TextSpan(
                                  text: "\nPet: ${profile.pet}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              : TextSpan(
                                  text: "\nAdd: pets",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                        ]),
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
                      builder: (BuildContext context) => ChildrenPets(
                            profile: profile,
                            source: documentUID,
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
                  Icon(Icons.search),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Looking for",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "\nGender: ${idealPerson.genders[0]}...",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          TextSpan(
                            text:
                                "\nAge: ${idealPerson.minAge} - ${idealPerson.maxAge}",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ]),
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
                      builder: (BuildContext context) => IdealPersonView(
                            profile: profile,
                            idealPerson: idealPerson,
                          )),
                );
              },
            ),
            Divider(
              color: Colors.grey[700],
            ),
            Column(
              children: buildQst(),
            ),
          ],
        ),
      ),
    );
  }
}
