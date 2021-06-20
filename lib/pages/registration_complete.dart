import 'package:flutter/material.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/widgets/style.dart';

class RegistrationComplete extends StatefulWidget {
  final String email, password;
  RegistrationComplete({Key key, this.email, this.password});

  @override
  _RegistrationCompleteState createState() => _RegistrationCompleteState();
}

class _RegistrationCompleteState extends State<RegistrationComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: appStyle.authBox(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: Colors.white70,
                    size: 100.0,
                  ),
                  Text(
                    "You have registered successfully. If your all details found correct, your ID will be verified within 72 Hours.",
                    style: TextStyle(fontSize: 22.0, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Login ID : ${widget.email}",
                        style: TextStyle(fontSize: 18.0, color: Colors.white70),
                      ),
                      Text(
                        "Password : ${widget.password}",
                        style: TextStyle(fontSize: 18.0, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              child: Container(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white70),
                    ),
                    onPressed: gotoLoginPage,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  gotoLoginPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
      ModalRoute.withName('/'),
    );
  }
}
