import 'dart:io';

import 'package:celebae/model/question.dart';

class Profile {
  String uid;
  String name;
  String email;
  String gender;
  String pronoun;
  String bodyType;
  String heightUnite;
  double height;
  String ethnicity;
  String religion;
  String sign;
  String politic;
  String employement;
  String education;
  String langue;
  String diet;
  String smoking;
  String drinking;
  String marijuana;
  String hasKids;
  String wantKids;
  String pet;
  List<String> orientation;
  String relationship;
  DateTime birthday;
  int age;
  String country;
  String city;
  double long;
  double lat;
  String interestConnections;
  List<File> pictures;
  List<String> picturesUrl;
  List<Question> listQuestion;
  String profileImageUrl;

  Profile(
      {this.uid,
      this.name,
      this.email,
      this.gender,
      this.pronoun,
      this.bodyType,
      this.heightUnite,
      this.height,
      this.ethnicity,
      this.religion,
      this.sign,
      this.politic,
      this.employement,
      this.education,
      this.langue,
      this.diet,
      this.smoking,
      this.drinking,
      this.marijuana,
      this.hasKids,
      this.wantKids,
      this.pet,
      this.orientation,
      this.relationship,
      this.birthday,
      this.age,
      this.country,
      this.city,
      this.long,
      this.lat,
      this.interestConnections,
      this.pictures,
      this.picturesUrl,
      this.listQuestion,
      this.profileImageUrl});

  @override
  String toString() {
    return "Name : $name\nEmail : $email\nGender : $gender\nPronoun : $pronoun\nBody Type : $bodyType\nHeight : $height\nEthnicity : $ethnicity\nReligion : $religion\nSign : $sign\nPolitic : $politic\nEmployement : $employement\nEducation : $education\nLangue : $langue\nDiet : $diet\nSmoking : $smoking\nDrinking : $drinking\nMarijuana : $marijuana\nHasKids : $hasKids\nWantKids : $wantKids\nPet : $pet\nOrientation : ${orientation.join(", ")}\nRelationship : $relationship\nBirthday : $birthday Age : $age\nCountry : $country\nCity : $city\nLong : $long\nLat : $lat\nInterest Connections : " +
        interestConnections +
        "\nPictures Url : " +
        picturesUrl.join("\n") +
        "Profile Image : $profileImageUrl" +
        questionToString();
  }

  String questionToString() {
    String s = "List Questions : \n";
    for (int i = 0; i < listQuestion.length; i++) {
      s += "\nQuestin ${i + 1} : ${listQuestion[i].question}";
      s += "\nAnswer ${i + 1} : ${listQuestion[i].answer}\n";
    }
    return s;
  }

  Map<String, dynamic> toJson() => {
        'gender': this.gender,
        'pronoun': this.pronoun,
        'bodyType': this.bodyType,
        'heightUnit': this.heightUnite,
        'height': this.height,
        'ethnicity': this.ethnicity,
        'religion': this.religion,
        'sign': this.sign,
        'politic': this.politic,
        'employement': this.employement,
        'education': this.education,
        'langue': this.langue,
        'diet': this.diet,
        'smoking': this.smoking,
        'drinking': this.drinking,
        'marijuana': this.marijuana,
        'hasKids': this.hasKids,
        'wantKids': this.wantKids,
        'pet': this.pet,
        'orientation': this.orientation,
        'relationship': this.relationship,
        'birthday': this.birthday,
        'country': this.country,
        'city': this.city,
        'longitude': this.long,
        'latitude': this.lat,
        'interestConnections': this.interestConnections,
        'profileImageUrl': this.profileImageUrl,
        'images': picturesUrl,
        'questions': [
          for (int i = 0; i < this.listQuestion.length; i++)
            listQuestion[i].toJson(),
        ]
      };
}
