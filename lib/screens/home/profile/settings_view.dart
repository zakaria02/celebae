import '../../../screens/home/profile/settings/password_view.dart';
import '../../../model/profile.dart';
import 'settings/email_view.dart';
import '../../../widgets/provider_widget.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  Profile profile;
  SettingsView({this.profile});
  @override
  State<StatefulWidget> createState() {
    return _SettingsViewState(profile: profile);
  }
}

class _SettingsViewState extends State<SettingsView> {
  Profile profile;
  _SettingsViewState({this.profile});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);

  showAlert(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("NO", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("YES", style: TextStyle(fontFamily: 'Poppins')),
      onPressed: () {
        Provider.of(context).auth.signOut();
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "Are you sure you want to log out ? ",
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

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Settings",
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
                    Icon(Icons.alternate_email),
                    SizedBox(
                      width: _width * 0.03,
                    ),
                    Text(
                      "EMAIL",
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
                        builder: (BuildContext context) => EmailView(
                              profile: profile,
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
                    Icon(Icons.vpn_key),
                    SizedBox(
                      width: _width * 0.03,
                    ),
                    Text(
                      "PASSWORD",
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
                        builder: (BuildContext context) => PasswordView(
                              profile: profile,
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
                    Icon(Icons.power_settings_new),
                    SizedBox(
                      width: _width * 0.03,
                    ),
                    Text(
                      "LOGOUT",
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
                  showAlert(context);
                },
              ),
              Divider(
                color: Colors.grey[700],
              ),
            ],
          ),
        ));
  }
}
