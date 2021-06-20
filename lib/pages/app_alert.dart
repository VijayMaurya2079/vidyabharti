import 'package:flutter/material.dart';
import 'package:vidyabharti/models/app_status.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/widgets/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AppAlertPage extends StatelessWidget {
  final AppStatus status;
  AppAlertPage(this.status);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: appStyle.authBox(),
        child: Center(
          child: status.app_status == "100"
              ? versionMessage(context)
              : Text(status.message),
        ),
      ),
    );
  }

  Widget versionMessage(context) {
    const url =
        'https://play.google.com/store/apps/details?id=org.vidyabhartionline.vidyabharti';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          status.version_message,
          style: TextStyle(color: Colors.white70, fontSize: 28),
          textAlign: TextAlign.center,
        ),
        RaisedButton(
          child: Text(
            "Open Play Store",
          ),
          onPressed: () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        SizedBox(height: 10.0),
        FlatButton(
          child: Text(
            "Skip",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
