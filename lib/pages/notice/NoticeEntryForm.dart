import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vidyabharti/models/country.dart';
import 'package:vidyabharti/models/distict.dart';
import 'package:vidyabharti/models/kshetra.dart';
import 'package:vidyabharti/models/nagar.dart';
import 'package:vidyabharti/models/notice_model.dart';
import 'package:vidyabharti/models/prant.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/samiti.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';
import 'package:file_picker/file_picker.dart';

class NoticeEntryForm extends StatefulWidget {
  @override
  _NoticeEntryFormState createState() => new _NoticeEntryFormState();
}

class _NoticeEntryFormState extends State<NoticeEntryForm> {
  final _user = NoticeModel(fk_country_id: null, fk_kshetra_id: null);
  final _regKey = GlobalKey<FormState>();
  String _filePath = "";
  List<Country> _countryList = List<Country>();
  List<Kshetra> _kshetraList = List<Kshetra>();
  List<Prant> _prantList = List<Prant>();
  List<Samiti> _samitiList = List<Samiti>();
  List<Distict> _distictList = List<Distict>();
  List<Nagar> _nagarList = List<Nagar>();

  @override
  void initState() {
    super.initState();
    getDefaultData();
    fetchCountry();
  }

  @override
  void dispose() {
    utill.isLoading = false;
  }

  fetchCountry() async {
    Result result1 = await db.country();
    final list = result1.data.map<Country>((i) => Country.fromJson(i)).toList();

    setState(() {
      _countryList = list;
      _user.fk_kshetra_id = null;
      _user.fk_prant_id = null;
      _user.fk_department_id = null;
      _user.fk_mahanagar_id = null;
      _user.fk_nagar_id = null;
      _kshetraList = List<Kshetra>();
      _prantList = List<Prant>();
      _samitiList = List<Samiti>();
      _distictList = List<Distict>();
      _nagarList = List<Nagar>();
    });
  }

  getDefaultData() async {
    fetchCountry();
  }

  fetchKshetra(String id) async {
    Result result = await db.kshetra(id);
    final list = result.data.map<Kshetra>((i) => Kshetra.fromJson(i)).toList();
    setState(() {
      _kshetraList = list;
      _user.fk_prant_id = null;
      _user.fk_department_id = null;
      _user.fk_mahanagar_id = null;
      _user.fk_nagar_id = null;
      _user.fk_school_id = null;
      _prantList = List<Prant>();
      _samitiList = List<Samiti>();
      _distictList = List<Distict>();
      _nagarList = List<Nagar>();
    });
  }

  fetchPrant(String id) async {
    Result result = await db.prant(id);
    final list = result.data.map<Prant>((i) => Prant.fromJson(i)).toList();
    setState(() {
      _prantList = list;
      _user.fk_department_id = null;
      _user.fk_mahanagar_id = null;
      _user.fk_nagar_id = null;
      _user.fk_school_id = null;
      _samitiList = List<Samiti>();
      _distictList = List<Distict>();
      _nagarList = List<Nagar>();
    });
  }

  prantChange(value) {
    _user.fk_department_id = null;
    _user.fk_mahanagar_id = null;
    _user.fk_nagar_id = null;
    _user.fk_school_id = null;
    _samitiList = List<Samiti>();
    _distictList = List<Distict>();
    _nagarList = List<Nagar>();
    fetchSamiti(value);
    fetchDistict(value);
  }

  fetchSamiti(String id) async {
    Result result = await db.samiti(id);
    final list = result.data.map<Samiti>((i) => Samiti.fromJson(i)).toList();
    setState(() {
      _samitiList = list;
    });
  }

  fetchDistict(String id) async {
    Result result = await db.distict(id);
    final list = result.data.map<Distict>((i) => Distict.fromJson(i)).toList();
    setState(() {
      _distictList = list;
    });
  }

  fetchNagar(String id) async {
    Result result = await db.nagar(id);
    final list = result.data.map<Nagar>((i) => Nagar.fromJson(i)).toList();
    setState(() {
      if (list.length > 0) {
        _nagarList = list;
        _user.fk_school_id = null;
      } else {
        _user.fk_nagar_id = null;
        _user.fk_school_id = null;
        _nagarList = List<Nagar>();
      }
    });
  }

  Widget _countryField() {
    return DropdownButtonFormField(
      value: _user.fk_country_id,
      items: _countryList.map((value) {
        return DropdownMenuItem(
          value: value.country_id,
          child: Text(value.country_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        fetchKshetra(value);
        setState(() {
          _user.fk_country_id = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select country';
        }
      },
      decoration: appStyle.inputDecoration("Select Country"),
    );
  }

  Widget _kshetraField() {
    return DropdownButtonFormField(
      value: _user.fk_kshetra_id,
      items: _kshetraList.map((value) {
        return DropdownMenuItem(
          value: value.kshetra_id,
          child: Text(value.kshetra_name),
        );
      }).toList(),
      onChanged: (value) {
        fetchPrant(value);
        setState(() {
          _user.fk_kshetra_id = value;
        });
      },
      hint: Text(""),
      decoration: appStyle.inputDecoration("Select Kshetra"),
    );
  }

  Widget _prantField() {
    return DropdownButtonFormField(
      value: _user.fk_prant_id,
      items: _prantList.map((value) {
        return DropdownMenuItem(
          value: value.prant_id,
          child: Text(value.prant_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        prantChange(value);
        setState(() {
          _user.fk_prant_id = value;
        });
      },
      decoration: appStyle.inputDecoration("Select Prant"),
    );
  }

  Widget _samitiField() {
    return DropdownButtonFormField(
      value: _user.fk_department_id,
      items: _samitiList.map((value) {
        return DropdownMenuItem(
          value: value.department_id,
          child: Text(value.department_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        setState(() {
          _user.fk_department_id = value;
        });
      },
      decoration: appStyle.inputDecoration("Select Samiti"),
    );
  }

  Widget _distictField() {
    return DropdownButtonFormField(
      value: _user.fk_mahanagar_id,
      items: _distictList.map((value) {
        return DropdownMenuItem(
          value: value.mahanagar_id,
          child: Text(value.mahanagar_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        fetchNagar(value);
        setState(() {
          _user.fk_mahanagar_id = value;
        });
      },
      decoration: appStyle.inputDecoration("Select District"),
    );
  }

  Widget _nagarField() {
    return DropdownButtonFormField(
      value: _user.fk_nagar_id,
      items: _nagarList.map((value) {
        return DropdownMenuItem(
          value: value.nagar_id,
          child: dropdownItemText(value.nagar_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        setState(() {
          _user.fk_nagar_id = value;
        });
      },
      decoration: appStyle.inputDecoration("Select Nagar"),
    );
  }

//user level controls end
  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Add Notice",
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: appStyle.authBox(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _regKey,
              autovalidate: false,
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: renderControls(),
                    builder: (context, controls) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controls.data,
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white70,
                      child: Text("Add Notice"),
                      onPressed: () {
                        _addNotice();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      validator: (value) {
        if (value.length < 20) {
          return 'Notice Title must be greater then 20 and less then 200 characters.';
        } else
          return null;
      },
      onSaved: (value) {
        _user.notice_title = value;
      },
      decoration: appStyle.inputDecoration("Notice Title"),
    );
  }

  Widget _noticeField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      onSaved: (value) {
        _user.notice_text = value;
      },
      decoration: appStyle.inputDecoration("Notice"),
    );
  }

  openGallery() async {
    try {
      final filePath = await FilePicker.getFilePath(
          type: FileType.custom, allowedExtensions: ["pdf"]);
      print("File path: " + filePath);
      _filePath = filePath;
      setState(() {
        _user.notice_attachment = generateFileName(filePath);
      });
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  generateFileName(String fileName) {
    var rng = new Random();
    var ext = (fileName.split('.')).last;
    fileName = rng.nextInt(1000000).toString() + "." + ext;
    return fileName;
  }

  _addNotice() async {
    _regKey.currentState.save();

    if (_regKey.currentState.validate()) {
      setState(() {
        utill.isLoading = true;
      });
      final id = await utill.getString("id");
      _user.fk_usm_user_id = id;
      _user.fk_mum_user_id = id;
      Result result = await db.noticeadd(_user);
      if (result.status) {
        await db.uploadPDF(_filePath, _user.notice_attachment);
        setState(() {
          utill.isLoading = false;
        });
        _regKey.currentState.reset();
        _user.notice_attachment = "";
        _filePath = "";
      } else {
        setState(() {
          utill.isLoading = false;
        });
      }
      print("${result.toJson()}");
    }
  }

  Future<List<Widget>> renderControls() async {
    return [
      _countryField(),
      appStyle.horizontalSpace(),
      _kshetraField(),
      appStyle.horizontalSpace(),
      _prantField(),
      appStyle.horizontalSpace(),
      _samitiField(),
      appStyle.horizontalSpace(),
      _distictField(),
      appStyle.horizontalSpace(),
      _nagarField(),
      appStyle.horizontalSpace(),
      _titleField(),
      appStyle.horizontalSpace(),
      _noticeField(),
      appStyle.horizontalSpace(),
      FlatButton(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Select File  :${_user.notice_attachment ?? ''}"),
          ),
        ),
        onPressed: () {
          openGallery();
        },
      )
    ];
  }

  dropdownItemText(String text) {
    return Container(
      width: 200,
      child: Text(
        text ?? "",
        overflow: TextOverflow.fade,
      ),
    );
  }
}
