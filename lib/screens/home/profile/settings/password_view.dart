import 'package:auto_size_text/auto_size_text.dart';
import '../../../../screens/signup_view.dart';
import '../../../../widgets/provider_widget.dart';
import '../../../../model/profile.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatefulWidget {
  Profile profile;
  PasswordView({this.profile});
  @override
  State<StatefulWidget> createState() {
    return _PasswordViewState(profile: profile);
  }
}

class _PasswordViewState extends State<PasswordView>
    with TickerProviderStateMixin {
  Profile profile;
  _PasswordViewState({this.profile});

  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final Color backgroundColor = Color(0xFFf8f3f5);

  int changed = 0;
  bool _state = false, _validPassword = false;
  final formKey = new GlobalKey<FormState>();
  String _password, _newPassword, _confirmNewPassword, _warning, _result;

  InputDecoration buildInputNameDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      contentPadding:
          const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(_warning, maxLines: 3),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
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
        "SAVE",
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

  void _validateInputs() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (!_state) animateButton();
      try {
        await Provider.of(context)
            .auth
            .updatePassword(profile.email, _password, _newPassword);
        setState(() {
          _state = false;
          _warning = "Your password has been successfully updated";
          _password = null;
          _newPassword = null;
          _confirmNewPassword = null;
        });
      } catch (e) {
        setState(() {
          _warning = e.message;
          _state = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Password",
          style: TextStyle(
              fontFamily: "Poppins", color: Colors.white, fontSize: 19),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(1),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.05,
                ),
                showAlert(),
                SizedBox(
                  height: _height * 0.05,
                ),
                TextFormField(
                  controller: TextEditingController(text: _password),
                  decoration: buildInputNameDecoration("Enter your password"),
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                    changed++;
                  },
                  onSaved: (value) {
                    _password = value;
                    changed++;
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'This field is obligatory';
                    return null;
                  },
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      textColor: primaryColor,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () async {
                        _result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUpView(
                                    authFormType: AuthFormType.reset,
                                    email: profile.email,
                                  )),
                        );
                        if (_result == "linkSent") {
                          setState(() {
                            _warning =
                                "A password reset link has been sent to ${profile.email}";
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                TextFormField(
                  controller: TextEditingController(text: _newPassword),
                  decoration:
                      buildInputNameDecoration("Enter your new password"),
                  obscureText: true,
                  onChanged: (value) {
                    _newPassword = value;
                    changed++;
                  },
                  onSaved: (value) {
                    _newPassword = value;
                    changed++;
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'This field is obligatory';
                    return null;
                  },
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextFormField(
                  controller: TextEditingController(text: _confirmNewPassword),
                  decoration:
                      buildInputNameDecoration("Confirm your new password"),
                  obscureText: true,
                  onChanged: (value) {
                    _confirmNewPassword = value;
                    changed++;
                  },
                  onSaved: (value) {
                    _confirmNewPassword = value;
                    changed++;
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return 'This field is obligatory';
                    else if (value != _newPassword)
                      return 'Your password and confirmation password do not match !!';
                    return null;
                  },
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                Container(
                  height: 57,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: _width,
                  child: RaisedButton(
                    onPressed: _state || changed == 0 ? null : _validateInputs,
                    child: _builButtonChild(),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
