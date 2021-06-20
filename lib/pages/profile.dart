import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vidyabharti/models/designation.dart';
import 'package:vidyabharti/models/profile.dart';
import 'package:vidyabharti/models/profile_bloc.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/school.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:vidyabharti/widgets/news_detail_templete.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileView _profileView = ProfileView();
  String id = "";
  bool editmode = false;
  String initialValue = "";
  final _formStatus = GlobalKey<FormState>();
  List<Designation> _designationList = [
    Designation(designation_id: '', designation_name: '')
  ];
  List<School> _schoolList = [School(school_id: '', school_name: '')];

  @override
  void initState() {
    getUserDetail();
    db.designation().then((Result result) {
      setState(() {
        _designationList = result.data
            .map<Designation>((i) => Designation.fromJson(i))
            .toList();
      });
    });
    super.initState();
  }

  getUserDetail() async {
    id = await utill.getString("id");
    profileBloc.list(id);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Profile",
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: profileBloc.getNewsList,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueGrey, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      profileImage(snapshot.data),
                      Material(
                        color: Colors.white,
                        elevation: 10.0,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            child: editmode
                                ? editDetail()
                                : viewDetail(snapshot.data),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  profileImage(ProfileView pv) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200.0,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey,
          child: ClipOval(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ViewNewsImage(
                      id: "popup_image",
                      url: pv.profile_image + "?" + DateTime.now().toString(),
                    );
                  },
                );
              },
              child: FadeInImage.assetNetwork(
                image: pv.profile_image + "?" + DateTime.now().toString(),
                placeholder: "assets/icon.png",
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  viewDetail(ProfileView pv) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Name"),
          subtitle: Text(pv.user_name ?? ""),
        ),
        ListTile(
          title: Text("Designation"),
          subtitle: Text(pv.user_designation ?? ""),
        ),
        ListTile(
          title: Text("Mobile No"),
          subtitle: Text(pv.user_mobile_no ?? ""),
        ),
        ListTile(
          title: Text("Email ID"),
          subtitle: Text(pv.user_email_id ?? ""),
        ),
        pv.school_name == ""
            ? Container()
            : ListTile(
                title: Text("School"),
                subtitle: Text(pv.school_name ?? ""),
              ),
        SizedBox(
          child: RaisedButton(
            child: Text("Edit"),
            onPressed: () async {
              setState(() {
                utill.isLoading = true;
              });
              Result result = await db.editUserDetail(id);
              setState(() {
                _profileView = ProfileView.fromJson(result.data);
                utill.isLoading = false;
                print("${_profileView.toJson()}");
              });
              db.school(pv.fk_mahanagar_id).then((Result result) {
                setState(() {
                  _schoolList = result.data
                      .map<School>((i) => School.fromJson(i))
                      .toList();
                  editmode = true;
                });
              });
            },
          ),
        )
      ],
    );
  }

  editDetail() {
    return Form(
      key: _formStatus,
      autovalidate: false,
      child: Column(
        children: <Widget>[
          ListTile(
            title: TextFormField(
              initialValue: _profileView.user_name,
              decoration: InputDecoration(
                labelText: "Name",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Name reuired";
                }
              },
              onSaved: (value) {
                _profileView.user_name = value;
              },
            ),
          ),
          checkDesignation(),
          ListTile(
            title: Text("Mobile No"),
            subtitle: Text(_profileView.user_mobile_no ?? ""),
          ),
          ListTile(
            title: Text("Email ID"),
            subtitle: Text(_profileView.user_email_id ?? ""),
          ),
          checkSchool(),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text("Update"),
                  onPressed: () {
                    updateProfile();
                  },
                ),
                RaisedButton(
                  child: Text("Update Profile Pic"),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: <Widget>[
                              ListTile(
                                title: FlatButton(
                                  child: Text("Open Camera"),
                                  onPressed: openCamera,
                                ),
                              ),
                              ListTile(
                                title: FlatButton(
                                  child: Text("Open Gallery"),
                                  onPressed: openGallery,
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
                RaisedButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    setState(() {
                      editmode = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateProfile() async {
    print(_profileView.toJson());
    _formStatus.currentState.save();
    if (_formStatus.currentState.validate()) {
      setState(() {
        utill.isLoading = true;
      });
      await db.updateUserDetail(_profileView);
      setState(() {
        editmode = false;
        profileBloc.list(id);
      });
    }
    setState(() {
      utill.isLoading = false;
    });
  }

  openCamera() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 500,
      );
      //image = await FlutterExifRotation.rotateImage(path: image.path);
      String base64Image = base64Encode(image.readAsBytesSync());
      setState(() {
        utill.isLoading = true;
      });
      await db.uploadProfileImage(
        base64Image,
        _profileView.pk_mum_user_id + ".png",
      );
      setState(() {
        utill.isLoading = false;
        editmode = false;
      });
      profileBloc.list(id);
    } catch (e) {
      print("$e");
    }
  }

  openGallery() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
      );
      //image = await FlutterExifRotation.rotateImage(path: image.path);
      String base64Image = base64Encode(image.readAsBytesSync());
      setState(() {
        utill.isLoading = true;
      });
      await db.uploadProfileImage(
        base64Image,
        _profileView.pk_mum_user_id + ".png",
      );
      setState(() {
        utill.isLoading = false;
        editmode = false;
      });
      profileBloc.list(id);
    } catch (e) {
      print("${e}");
    }
  }

  checkSchool() {
    if (_profileView.school_name == "" ||
        _profileView.school_name == null ||
        _profileView.school_name == "null") {
      return Container();
    } else {
      return ListTile(
        title: DropdownButtonFormField(
          value:
              _profileView.school_name == "" ? null : _profileView.school_name,
          decoration: InputDecoration(
            labelText: "School",
          ),
          items: _schoolList.map(
            (value) {
              return DropdownMenuItem(
                value: value.school_id,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    value.school_name,
                    overflow: TextOverflow.fade,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              _profileView.school_name = value;
            });
          },
          validator: (String value) {
            if (value.isEmpty || value == null) {
              return 'Please select school';
            }
          },
        ),
      );
    }
  }

  checkDesignation() {
    print(_profileView.user_designation.substring(0, 2));
    if (_profileView.user_designation.trim() == "" ||
        _profileView.user_designation == null ||
        _profileView.user_designation == "null" ||
        _profileView.user_designation.substring(0, 2) != "DG") {
      return ListTile(
        title: TextFormField(
          initialValue: _profileView.user_designation,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Designation",
          ),
          onSaved: (value) {
            _profileView.user_designation = value;
          },
        ),
      );
    } else {
      return ListTile(
        title: DropdownButtonFormField(
          value: _profileView.user_designation.trim() == ""
              ? null
              : _profileView.user_designation,
          decoration: InputDecoration(
            labelText: "Designation",
          ),
          items: _designationList.map(
            (value) {
              return DropdownMenuItem(
                value: value.designation_id,
                child: Text(value.designation_name),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              _profileView.user_designation = value;
            });
          },
          validator: (String value) {
            if (value.isEmpty || value == null) {
              return 'Please select designation';
            }
          },
        ),
      );
    }
  }
}
