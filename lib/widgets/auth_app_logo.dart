import 'package:flutter/material.dart';

class AuthAppLogo extends StatelessWidget {
  const AuthAppLogo({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.transparent,
      ),
      child: Image.asset(
        "assets/icon.png",
        width: 150,
        height: 120.0,
      ),
    );
  }
}
