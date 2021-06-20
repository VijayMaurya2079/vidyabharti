import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vidyabharti/models/app_status.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/app_alert.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/auth_app_logo.dart';
import 'package:vidyabharti/widgets/style.dart';
import 'package:package_info/package_info.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String msg =
      "इस प्रकार की राष्ट्रीय शिक्षा प्रणाली का विकास करना है जिसके द्वारा ऐसी युवा पीढ़ी का निर्माण हो सके जो हिन्दुत्वनिष्ठ एवं राष्ट्रभक्ति से ओतप्रोत हो, शारीरिक, प्राणिक, मानसिक, बौद्धिक,एवं आध्यात्मिक दृष्टि से पूर्ण विकसित हो तथा जो जीवन की वर्तमान चुनौतियों का सामना सफलता पूर्वक कर सके और उसका जीवन ग्रामों, वनों, गिरि कंदराओं एवं झुग्गी- झोपड़ियों में निवास करने वाले दीन-दु:खी अभावग्रस्त अपने बांधवों को सामाजिक कुरीतियों, शोषण एवं अन्याय से मुक्त कराकर राष्ट्र जीवन को समरस, सुसम्पन्न एवं सुसंस्कृत बनाने के लिए समर्पित हो।";
  AudioPlayer audioPlayer;
  bool playerState = true;

  @override
  void initState() {
    super.initState();
    audioPlayer = new AudioPlayer();
    play();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  Future<void> play() async {
    await audioPlayer.play("http://www.vidyabhartionline.org/music/1.mp3");
    setState(() => playerState = true);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() => playerState = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: appStyle.authBox(),
        padding: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            AuthAppLogo(),
            SizedBox(height: 25.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Text(
                    "विद्या भारती",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "अखिल भारतीय  शिक्षा संस्थान",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "हमारा लक्ष्य",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    msg,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.8),
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 50.0,
              icon: playerState
                  ? Icon(
                      Icons.pause_circle_filled,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                    ),
              onPressed: () {
                playerState ? stop() : play();
              },
            ),
            MaterialButton(
              elevation: 1.0,
              color: Colors.deepOrange,
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAppStatus();
              },
            )
          ],
        ),
      ),
    );
  }

  checkAppStatus() async {
    Result result = await db.appstatus();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    if (result.status) {
      AppStatus appStatus = AppStatus.fromJson(result.data);
      if (appStatus.app_status == "0") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AppAlertPage(appStatus),
          ),
        );
        } else if (appStatus.version.trim() != version.trim()) {
          appStatus.app_status = "100";
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AppAlertPage(appStatus),
            ),
          );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => DashboardPage(),
          ),
        );
      }
    }
  }
}
