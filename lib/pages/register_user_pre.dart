import 'package:flutter/material.dart';
import 'package:vidyabharti/pages/register_user.dart';
import 'package:vidyabharti/widgets/style.dart';

class RegisterUserPre extends StatefulWidget {
  @override
  _RegisterUserPreState createState() => new _RegisterUserPreState();
}

class _RegisterUserPreState extends State<RegisterUserPre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height+200,
          width: MediaQuery.of(context).size.width,
          decoration: appStyle.authBox(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: Text(
                  "Select Your Designation",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("राष्ट्रीय पदाधिकारी"),
                      onTap: () => navigate(1),
                    ),
                    ListTile(
                      title: Text("क्षेत्रीय पदाधिकारी"),
                      onTap: () => navigate(2),
                    ),
                    ListTile(
                      title: Text("प्रांतीय पदाधिकारी"),
                      onTap: () => navigate(3),
                    ),
                    ListTile(
                      title: Text("सम्भागीय पदाधिकारी"),
                      onTap: () => navigate(4),
                    ),
                    ListTile(
                      title: Text("प्रबंध समिति"),
                      onTap: () => navigate(5),
                    ),
                    ListTile(
                      title: Text("प्रबंधक"),
                      onTap: () => navigate(6),
                    ),
                    ListTile(
                      title: Text("प्राचार्य"),
                      onTap: () => navigate(7),
                    ),
                    ListTile(
                      title: Text("आचार्य"),
                      onTap: () => navigate(8),
                    ),
                    ListTile(
                      title: Text("अन्य"),
                      onTap: () => navigate(9),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  navigate(int i) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterUser(i.toString());
        },
      ),
    );
  }
}
