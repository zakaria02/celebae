import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'screens/profile_info/user_gender_view.dart';
import 'widgets/provider_widget.dart';
import 'screens/get_started_view.dart';
import 'screens/signup_view.dart';
import 'screens/home/home_view.dart';
import 'screens/profile_info/welcome_view.dart';
import 'services/auth_service.dart';
import 'widgets/CircularProgressWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xFFff0e55);
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.signUp,
              ),
          '/signIn': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.signIn,
              ),
          '/welcomeProfile': (BuildContext context) => WelcomeProfile(),
          '/userGender': (BuildContext context) => UserGender(),
          //'/userBirthday': (BuildContext context) => UserBirthday(),
          //'/userLocation': (BuildContext context) => UserLocation(),
          //'/welcomeInterest': (BuildContext context) => WelcomeInterest(),
          //'/connectionInterest': (BuildContext context) => ConnectionInterest(),
          //'/ageInterest': (BuildContext context) => AgeInterest(),
          //'/tellUs': (BuildContext context) => TellUs(),
          //'/userImages': (BuildContext context) => UserImages(),
          //'/userDescription': (BuildContext context) => UserDescription(),
          '/home': (BuildContext context) => HomeController(),
        },
      ),
    );
  }
}

// upload user's profile
Stream<QuerySnapshot> getUserProfileStreamSnapchots(
    BuildContext context) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  yield* Firestore.instance
      .collection("userData")
      .document(uid)
      .collection('profile')
      .snapshots();
}

// if the user have profile then go to home else create a profile
StreamBuilder getProfile(BuildContext context) {
  return StreamBuilder(
    stream: getUserProfileStreamSnapchots(context),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.documents.length > 0) return Home();
        return WelcomeProfile();
      } else
        return CircularProgressWidget();
    },
  );
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          if (signedIn) {
            return getProfile(context);
          } else {
            return GetStarted();
          }
        }
        return CircularProgressWidget();
      },
    );
  }
}
