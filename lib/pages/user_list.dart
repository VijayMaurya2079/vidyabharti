import 'package:flutter/material.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/user_list.dart';
import 'package:vidyabharti/models/user_list_bloc.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/master_view.dart';

import 'package:vidyabharti/widgets/style.dart';

class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String _status = "Pending Users";

  initState() {
    super.initState();
    userListBloc.getList(_status == "Registered Users" ? "1" : "0");
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Approve User",
      child: Container(
        decoration: appStyle.authBox(),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white70,
                padding: EdgeInsets.all(5.0),
                child: DropdownButtonFormField(
                  value: _status,
                  items: ["Registered Users", "Pending Users"].map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                      userListBloc
                          .getList(_status == "Registered Users" ? "1" : "0");
                    });
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                child: StreamBuilder(
                  stream: userListBloc.getUserList,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      default:
                        return snapshot.data.length == 0
                            ? Center(
                                child: Text(
                                  "You don't have User Approval right.",
                                  style: TextStyle(color: Colors.white30),
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return userTemplet(snapshot.data[index]);
                                },
                              );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  userTemplet(UserListView view) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              view.user_name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          userDetailTemp("Designation", view.user_designation),
          userDetailTemp("Mobile No", view.user_mobile_no),
          userDetailTemp("Email ID", view.user_email_id),
          userDetailTemp("Kshetra", view.kshetra_name),
          userDetailTemp("Prant", view.prant_name),
          userDetailTemp("District", view.mahanagar_name),
          userDetailTemp("School", view.school_name),
          actionButton(view),
        ],
      ),
    );
  }

  actionButton(UserListView view) {
    return Row(
      children: <Widget>[
        _status == "Registered Users"
            ? SizedBox()
            : RaisedButton(
                child: Text("Activate"),
                onPressed: () {
                  db.activateUser(view.pk_mum_user_id).then((Result res) {
                    if (res.status) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("User Activation"),
                              content: Text(
                                  "User Account ${view.user_name} activated successfully."),
                            );
                          });
                      userListBloc
                          .getList(_status == "Registered Users" ? "1" : "0");
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("User Account activation fail."),
                            );
                          });
                    }
                  });
                },
              ),
        SizedBox(
          width: 5.0,
        ),
        RaisedButton(
          child: Text("Delete"),
          onPressed: () {
            db.activateUser(view.pk_mum_user_id).then((Result res) {
              if (res.status) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete User"),
                        content: Text(
                            "User Account ${view.user_name} deleted successfully."),
                      );
                    });
                userListBloc.getList(_status == "Registered Users" ? "1" : "0");
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("User Account deletion fail."),
                      );
                    });
              }
            });
          },
        ),
      ],
    );
  }

  userDetailTemp(key, value) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            child: Text(key),
          ),
          Expanded(
            child: Text(value ?? ""),
          ),
        ],
      ),
    );
  }
}
