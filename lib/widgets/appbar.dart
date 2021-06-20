import 'package:flutter/material.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/pages/new_approval_filter_news.dart';
import 'package:vidyabharti/provider/utill.dart';

class AppDrawer extends StatefulWidget {
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userid;

  @override
  void initState() {
    getUserID();
    super.initState();
  }

  getUserID() async {
    setState(() async {
      userid = await utill.getString("name");
    });
  }

  Widget menuItem(
      BuildContext context, dynamic icon, String name, dynamic screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Vidya Bharti Online"),
            accountEmail: Text("info@vidyabharti.com"),
            currentAccountPicture: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/icon.png"),
            ),
          ),
          menuItem(
            context,
            Icons.dashboard,
            "Dashboard",
            DashboardPage(),
          ),
          menuItem(
            context,
            Icons.dashboard,
            "News Approval",
            NewsApprovalFilterNews(),
          ),
          userid ??
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Logout"),
                onTap: logout,
              ),
        ],
      ),
    );
  }

  void logout() async {
    await utill.deleteLocal("id");
    await utill.deleteLocal("name");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => DashboardPage()),
      ModalRoute.withName('/'),
    );
  }
}
