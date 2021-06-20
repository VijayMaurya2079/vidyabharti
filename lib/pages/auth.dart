import 'package:vidyabharti/models/auth.dart';
import 'package:vidyabharti/widgets/auth_app_logo.dart';
import 'package:vidyabharti/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:vidyabharti/widgets/style.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String mode = "Login";

  void initState() {
    super.initState();
    authMode.getMode.listen((value) {
      setState(() {
        print("Current Mode $value");
        mode = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: appStyle.authBox(),
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
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
                    LoginPage()
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
}