import 'package:flutter/material.dart';

class AppStyle {
  SizedBox horizontalSpace() {
    return SizedBox(
      height: 5.0,
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
    );
  }

  InputDecoration inputDecorationWithCount(String label, int count, int max) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      counterText: "$count/$max",
    );
  }

  InputDecoration inputDecoration2(String label) {
    return InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        errorStyle: TextStyle(color: Colors.white70));
  }

  BoxDecoration authBox() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/background.jpg"),
        colorFilter: ColorFilter.mode(Colors.orange, BlendMode.difference),
        fit: BoxFit.cover,
      ),
      color: Colors.blue,
    );
  }

  BoxDecoration gradiantBox() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.deepOrangeAccent, Colors.yellow[50]],
      ),
    );
  }
}

final appStyle = AppStyle();
