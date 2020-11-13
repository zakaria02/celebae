import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/provider_widget.dart';

enum AuthFormType { signIn, signUp, reset }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;
  String email;

  SignUpView({Key key, @required this.authFormType, this.email})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpViewState(authFormType: this.authFormType, email: email);
  }
}

class _SignUpViewState extends State<SignUpView> {
  final Color primaryColor = Color(0xFFff0e55);
  final Color secondaryColor = Colors.white;
  AuthFormType authFormType;
  String email;
  _SignUpViewState({this.authFormType, this.email});
  final formKey = GlobalKey<FormState>();
  String _email, _password, _username, _warning;

  void switchFormatState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  Future submitAnonymous() async {
    final auth = Provider.of(context).auth;
    await auth.signInAnonymously();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          auth.sendPasswordResetEmail(_email);
          _warning = "A password reset link has been sent to $_email";
          if (email == null) {
            setState(() {
              authFormType = AuthFormType.signIn;
            });
          } else
            Navigator.pop(context, 'linkSent');
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _username);
          print("Signed Up with New ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _email = email;
    print("email : $email");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Image.asset("assets/images/app_bar_1.png"),
          showAlert(),
          SizedBox(
            height: _height * 0.025,
          ),
          Image.asset(
            "assets/images/logo.jpeg",
            height: 300,
          ),
          SizedBox(
            height: _height * 0.025,
          ),
          Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: buildInputs() + buildButtons(),
                ),
              )),
        ],
      )),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    // if were in reset password state add just email
    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
            style: TextStyle(fontSize: 22),
            decoration: buildSignUpInputDecoration("Email"),
            controller: TextEditingController(text: _email),
            onSaved: (value) => _email = value,
            validator: (value) {
              if (value.isEmpty) return 'This field is obligatory!';

              return null;
            }),
      );
      textFields.add(SizedBox(
        height: 20.0,
      ));
      return textFields;
    }
    // if were in the sign up state add name
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
            style: TextStyle(fontSize: 22),
            decoration: buildSignUpInputDecoration("Name"),
            onSaved: (value) => _username = value,
            validator: (value) {
              if (value.isEmpty) {
                return 'This field is obligatory!';
              }
              return null;
            }),
      );
      textFields.add(SizedBox(
        height: 20.0,
      ));
    }
    //add email & password
    textFields.add(
      TextFormField(
          style: TextStyle(fontSize: 22),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
          validator: (value) {
            if (value.isEmpty) return 'This field is obligatory!';

            return null;
          }),
    );
    textFields.add(SizedBox(
      height: 20.0,
    ));
    textFields.add(
      TextFormField(
          style: TextStyle(fontSize: 22),
          decoration: buildSignUpInputDecoration("Password"),
          onSaved: (value) => _password = value,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) return 'This field is obligatory!';
            return null;
          }),
    );
    textFields.add(SizedBox(
      height: 20.0,
    ));
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: hint == "Name"
          ? Icon(
              Icons.person,
              color: primaryColor,
            )
          : hint == "Email"
              ? Icon(
                  Icons.email,
                  color: primaryColor,
                )
              : Icon(
                  Icons.vpn_key,
                  color: primaryColor,
                ),
      hintText: hint,
      filled: true,
      fillColor: secondaryColor,
      focusColor: Colors.white,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(5.0),
      ),
      contentPadding:
          const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButton, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;

    if (authFormType == AuthFormType.signIn) {
      _switchButton = "Register";
      _newFormState = "signUp";
      _submitButtonText = "SIGN IN";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButton = "Login";
      _newFormState = "signIp";
      _submitButtonText = "RESET PASSWORD";
    } else {
      _switchButton = "Login";
      _newFormState = "signIn";
      _submitButtonText = "SIGN UP";
    }

    return [
      SizedBox(
        height: 8,
      ),
      Container(
        width: 260,
        height: 45,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: primaryColor,
          textColor: secondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontFamily: "Poppins", fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: submit,
        ),
      ),
      SizedBox(
        height: 4,
      ),
      _showForgotPassword
          ? Row(
              children: <Widget>[
                MaterialButton(
                  textColor: primaryColor,
                  child: Text(_switchButton,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center),
                  onPressed: () {
                    switchFormatState(_newFormState);
                  },
                ),
                Spacer(),
                showForgotPassword(_showForgotPassword),
              ],
            )
          : (email == null)
              ? MaterialButton(
                  textColor: primaryColor,
                  child: Text(_switchButton,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                  onPressed: () {
                    switchFormatState(_newFormState);
                  },
                )
              : SizedBox(
                  width: 0,
                ),
    ];
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

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: MaterialButton(
        textColor: primaryColor,
        child: Text("Forgot Password?",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
            ),
            textAlign: TextAlign.center),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }
}
