import 'package:flutter/material.dart';
import 'package:vidyabharti/models/change_password.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => new _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ChangePassword _login = ChangePassword();
  final _formStatus = GlobalKey<FormState>();

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Enter Old Password',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.white)),
      obscureText: true,
      onSaved: (String value) {
        _login.password = value;
      },
    );
  }

  Widget _newPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Write New Password',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.white)),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password length must be atleast 6 characters.';
        }
      },
      onSaved: (String value) {
        _login.new_password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Change Password",
      child: Container(
        decoration: appStyle.authBox(),
        child: Center(
          child: Container(
            height: 250.0,
            padding: EdgeInsets.all(10.0),
            child: Material(
              color: Colors.white.withOpacity(0.5),
              elevation: 10.0,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formStatus,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _passwordField(),
                      _newPasswordField(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: RaisedButton(
                          color: Colors.deepOrange,
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: change,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  change() async {
    _formStatus.currentState.save();
    if (_formStatus.currentState.validate()) {
      String id = await utill.getString("id");
      _login.user_email_id = id;
      Result result = await db.changePassword(_login);
      if (result.status) {
        _formStatus.currentState.reset();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success Message"),
              content: Text("${result.message}"),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Message"),
              content: Text("${result.message}"),
            );
          },
        );
      }
    }
  }
}
