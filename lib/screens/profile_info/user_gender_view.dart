import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import '../../model/idealPerson.dart';
import '../../model/question.dart';
import 'user_birthday_view.dart';
import '../../widgets/error_message_widget.dart';
import '../../model/profile.dart';
import 'package:flutter/material.dart';

class UserGender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserGenderState();
  }
}

class _UserGenderState extends State<UserGender> {
  bool _manSelected = false,
      _womanSelected = false,
      _otherSelected = false,
      _err = false;
  final Color primaryColor = Color(0xFFff0e55);
  List<Question> listQst = [
    Question(question: "My self-summary", answer: ""),
    Question(question: "Most people that know me would say I'm", answer: ""),
    Question(question: "Favourite memory from my childhood", answer: ""),
    Question(question: "Things I am not", answer: ""),
    Question(question: "What I'm doing with my life", answer: ""),
    Question(question: "I'd like to be known for my", answer: ""),
    Question(question: "My dream job is", answer: ""),
    Question(question: "I could probably beat you at", answer: ""),
    Question(question: "I like to make", answer: ""),
    Question(question: "I want to be better at", answer: ""),
    Question(question: "My worst quality", answer: ""),
    Question(question: "My golden rule", answer: ""),
    Question(question: "The first thnig people notice about me", answer: ""),
    Question(question: "My partner should be", answer: ""),
    Question(question: "I value", answer: ""),
    Question(question: "A perfect day", answer: ""),
    Question(question: "what I'm actually looking for", answer: ""),
  ];
  String _gender = "";
  List<String> _genders = ["Men", "Women", "Others"];
  List<String> _orientation = [
    "Straight",
    "Gay",
    "Bisexual",
    "Lesbian",
    "Queer",
    "Pansexual",
    "Questioning",
    "Heteroflexible",
    "Homoflexible",
    "Asexual",
    "Gray-asexual",
    "Demisexual",
    "Reciprosexual",
    "Akiosexual",
    "Aceflux",
    "Grayromantic",
    "Demiromantic",
    "Recipromantic",
    "Akioromantic",
    "Aroflux",
  ];
  List<String> _connections = [
    "New friends",
    "Long-term dating",
    "Short-term dating",
    "Hookups"
  ];
  List<String> _status = ["Single", "Partnered", "Married"];
  List<String> _bodyTypes = [
    "Thin",
    "Overweight",
    "Average build",
    "Fit",
    "Jacked",
    "A little extra",
    "Curvy",
    "Full figured"
  ];
  List<String> _ethnicities = [
    "Asian",
    "Black",
    "Hispanic/Latin",
    "Indian",
    "Middle Eastern",
    "Native American",
    "Pacific Islander",
    "White",
    "Other"
  ],
      _religions = [
    "Agnosticism",
    "Atheism",
    "Christianity",
    "Judaism",
    "Catholicism",
    "Islam",
    "Hinduism",
    "Buddhism",
    "Sikh",
    "Other"
  ],
      _signs = [
    "Aquarius",
    "Pisces",
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn"
  ],
      _politics = [
    "Politically liberal",
    "Politically moderate",
    "Plitically conservative",
    "Other"
  ],
      _employments = [
    "Full-time",
    "Part-time",
    "Freelance",
    "Self-employed",
    "Unemployed",
    "Retired"
  ],
      _educations = [
    "High school",
    "Tade/tech school",
    "In college",
    "Undergraduate degree",
    "In grad school",
    "Graduate degree"
  ],
      _langues = [
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Basque",
    "Bengali",
    "Byelorussian",
    "Burmese",
    "Bulgarian",
    "Catalan",
    "Czech",
    "Chinese",
    "Croatian",
    "Danish",
    "Dari",
    "Dzongkha",
    "Dutch",
    "English",
    "Esperanto",
    "Estonian",
    "Faroese",
    "Farsi",
    "Finnish",
    "French",
    "Gaelic",
    "Galician",
    "German",
    "Greek",
    "Hebrew",
    "Hindi",
    "Hungarian",
    "Icelandic",
    "Indonesian",
    "Inuktitut (Eskimo)",
    "Italian",
    "Japanese",
    "Khmer",
    "Korean",
    "Kurdish",
    "Laotian",
    "Latvian",
    "Lappish",
    "Lithuanian",
    "Macedonian",
    "Malay",
    "Maltese",
    "Nepali",
    "Norwegian",
    "Pashto",
    "Polish",
    "Portuguese",
    "Romanian",
    "Russian",
    "Scots",
    "Serbian",
    "Slovak",
    "Slovenian",
    "Somali",
    "Spanish",
    "Swedish",
    "Swahili",
    "Tagalog-Filipino",
    "Tajik",
    "Tamil",
    "Thai",
    "Tibetan",
    "Tigrinya",
    "Tongan",
    "Turkish",
    "Turkmen",
    "Ucrainian",
    "Urdu",
    "Uzbek",
    "Vietnamese",
    "Welsh"
  ];
  List<String> _choice = ["Never", "Sometimes", "Often"],
      _diets = [
    "Omnivore",
    "Vegetarian",
    "Vegan",
    "Kosher",
    "Halal",
    "Gluten Free",
    "Pescatarian",
    "Jain",
    "Lactovegetarian",
    "Intermittent Fasting",
    "Ketogenic"
  ];
  List<String> _pets = ["Dog(s)", "Cat(s)", "Other", "None"],
      _hasKids = ["Has kid(s)", "Doesn't have kid(s)"],
      _wantKids = ["Might want kid(s)", "Wants kid(s)", "Doesn't want kid(s)"];

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
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
              height: _height * 0.06,
            ),
            AutoSizeText(
              "I am a",
              style: TextStyle(fontSize: 33, fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _manSelected = !_manSelected;
                                _womanSelected = false;
                                _otherSelected = false;
                                _gender = "Man";
                              });
                            },
                            child: Image.asset(
                              _manSelected
                                  ? "assets/images/man_selected.png"
                                  : "assets/images/man.png",
                              height: _height * 0.15,
                              width: _height * 0.15,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Man",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: _manSelected ? primaryColor : Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _womanSelected = !_womanSelected;
                                _manSelected = false;
                                _otherSelected = false;
                                _gender = "Woman";
                              });
                            },
                            child: Image.asset(
                              _womanSelected
                                  ? "assets/images/woman_selected.png"
                                  : "assets/images/woman.png",
                              height: _height * 0.15,
                              width: _height * 0.15,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Woman",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color:
                                  _womanSelected ? primaryColor : Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _otherSelected = !_otherSelected;
                            _manSelected = false;
                            _womanSelected = false;
                            _gender = "Other";
                          });
                        },
                        child: Image.asset(
                          _otherSelected
                              ? "assets/images/other_selected.png"
                              : "assets/images/other.png",
                          height: _height * 0.15,
                          width: _height * 0.15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Other",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: _otherSelected ? primaryColor : Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            Visibility(
              visible: _err,
              child: ErrorMessage(text: "Please make a choice"),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            Container(
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
                    if (!_manSelected && !_womanSelected && !_otherSelected) {
                      setState(() {
                        _err = true;
                      });
                    } else {
                      setState(() {
                        _err = false;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserBirthday(
                                  profile: Profile(
                                    name: "",
                                    email: "",
                                    gender: _gender,
                                    pronoun: "(leave this blank)",
                                    bodyType: "(leave this blank)",
                                    ethnicity: "(leave this blank)",
                                    religion: "(leave this blank)",
                                    sign: "(leave this blank)",
                                    politic: "(leave this blank)",
                                    employement: "(leave this blank)",
                                    education: "(leave this blank)",
                                    langue: "(leave this blank)",
                                    diet: "(leave this blank)",
                                    smoking: "(leave this blank)",
                                    drinking: "(leave this blank)",
                                    marijuana: "(leave this blank)",
                                    hasKids: "(leave this blank)",
                                    wantKids: "(leave this blank)",
                                    pet: "(leave this blank)",
                                    heightUnite: "cm",
                                    height: 0,
                                    orientation: ["Straight"],
                                    relationship: "Single",
                                    birthday: DateTime.now(),
                                    age: 0,
                                    country: "",
                                    city: "",
                                    long: 0,
                                    lat: 0,
                                    interestConnections: "",
                                    pictures: List<File>(),
                                    picturesUrl: List<String>(),
                                    listQuestion: listQst,
                                    profileImageUrl: "",
                                  ),
                                  idealPerson: IdealPerson(
                                    genders: _genders,
                                    orientations: _orientation,
                                    distance: "100",
                                    minAge: 0,
                                    maxAge: 0,
                                    connections: _connections,
                                    status: _status,
                                    bodyTypes: _bodyTypes,
                                    minHeight: 150,
                                    maxHeight: 170,
                                    ethnicities: _ethnicities,
                                    religions: _religions,
                                    signs: _signs,
                                    politics: _politics,
                                    employments: _employments,
                                    educations: _educations,
                                    langues: _langues,
                                    alcohol: _choice,
                                    smoking: _choice,
                                    marijuana: _choice,
                                    diets: _diets,
                                    pets: _pets,
                                    hasKids: _hasKids,
                                    wantKids: _wantKids,
                                  ),
                                )),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
