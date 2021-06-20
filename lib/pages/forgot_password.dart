import 'package:flutter/material.dart';
import 'package:vidyabharti/models/change_password.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/auth_app_logo.dart';
import 'package:vidyabharti/widgets/style.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ChangePassword _login = ChangePassword();
  final _formStatus = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: appStyle.authBox(),
        child: Container(
          padding: EdgeInsets.only(top: 150.0),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AuthAppLogo(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vidya Bharti Online",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formStatus,
                      child: _emailField(),
                    ),
                    _forgotButton(),
                    _loginButton()
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.black38,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(
                        "Design & Developed by Bito Technologies",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Enter registered email id.',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.white)),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _login.user_email_id = value;
      },
    );
  }

  Widget _forgotButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: MaterialButton(
        elevation: 10.0,
        color: Colors.red,
        child: Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => resetPassword(),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: 120,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: FlatButton(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white70,
            ),
          ),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthPage(),
                ),
              ),
        ),
      ),
    );
  }

  resetPassword() async {
    _formStatus.currentState.save();
    if (_formStatus.currentState.validate()) {
      Result result = await db.forgotPassword(_login.user_email_id);
      print(result.toJson());
      if (result.status) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Password Reset"),
              content: Text(result.message),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    _formStatus.currentState.reset();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Message"),
              content: Text(result.message),
            );
          },
        );
      }
    }
  }
}
