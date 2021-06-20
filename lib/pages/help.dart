import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/widgets/master_view.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Help",
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "विद्या भारती के इस एप में समाचार पोस्ट करने, शेयर करने में या किसी भी तरह की समस्या होने पर आप अवश्य संपर्क करें।"),
            Text(
              "श्री दिवाकर मिश्रा",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                "क्षेत्रीय सह संयोजक, प्रचार विभाग, विद्या भारती (पूर्वी उप्र)"),
            GestureDetector(
              onTap: () {
                launch("tel:9415037578");
              },
              child: Text(
                "9415037578",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch("tel:05224335444");
              },
              child: Text(
                "05224335444",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch("mailto:admin@vidyabhartionline.org");
              },
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Email :",
                    style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "admin@vidyabhartionline.org",
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
