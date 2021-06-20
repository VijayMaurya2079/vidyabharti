import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/useBloc.dart';
import 'package:vidyabharti/models/user.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/pages/forgot_password.dart';
import 'package:vidyabharti/pages/register_user_pre.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  UserLogin _login = UserLogin(user_email_id: "", user_name: "", password: "");
  final _loginStatus = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.emailAddress,
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

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.white)),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _login.password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _loginStatus,
        child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            SizedBox(
              height: 5.0,
            ),
            _buildPasswordTextField(),
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text("Login"),
                color: Colors.black12,
                textColor: Colors.white,
                onPressed: gotoDashboard,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: FlatButton(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
                color: Colors.transparent.withOpacity(0.0),
                textColor: Colors.black,
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: FlatButton(
                child: Text(
                  "New User",
                  style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
                color: Colors.transparent.withOpacity(0.0),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterUserPre()),
                  );
                },
              ),
            ),
            utill.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  gotoDashboard() {
    setState(() {
      utill.isLoading = true;
    });
    _loginStatus.currentState.save();
    if (_loginStatus.currentState.validate()) {
      db.login(_login).then((Result result) async {
        setState(() {
          utill.isLoading = false;
        });
        if (result.status) {
          FirebaseMessaging fcm = FirebaseMessaging();
          await utill.saveString("id", result.data[0]["pk_mum_user_id"]);
          await utill.saveString("name", result.data[0]["user_name"]);
          fcm.subscribeToTopic(result.data[0]["pk_mum_user_id"]);
          userBloc.setAppState();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DashboardPage()),
            ModalRoute.withName('/'),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Login Alert"),
                content: Text("${result.message}"),
              );
            },
          );
        }
      });
    } else {
      setState(() {
        utill.isLoading = false;
      });
    }
  }
}
