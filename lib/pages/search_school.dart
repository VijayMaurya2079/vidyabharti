import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vidyabharti/models/country.dart';
import 'package:vidyabharti/models/kshetra.dart';
import 'package:vidyabharti/models/distict.dart';
import 'package:vidyabharti/models/nagar.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/prant.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/school.dart';
import 'package:vidyabharti/models/samiti.dart';
import 'package:vidyabharti/pages/school_list.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class SearchSchoolNews extends StatefulWidget {
  @override
  _SearchSchoolNewsState createState() => _SearchSchoolNewsState();
}

class _SearchSchoolNewsState extends State<SearchSchoolNews> {
  final _user = NewsApprovalFilter();
  final _regKey = GlobalKey<FormState>();
  List<Country> _countryList = List<Country>();
  List<Kshetra> _kshetraList = List<Kshetra>();
  List<Prant> _prantList = List<Prant>();
  List<Samiti> _samitiList = List<Samiti>();
  List<Distict> _distictList = List<Distict>();
  List<Nagar> _nagarList = List<Nagar>();
  List<School> _schoolList = List<School>();

  @override
  void initState() {
    super.initState();
    fetchCountry();
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
      _user.fk_school_id = null;
      _kshetraList = List<Kshetra>();
      _prantList = List<Prant>();
      _samitiList = List<Samiti>();
      _distictList = List<Distict>();
      _nagarList = List<Nagar>();
      _schoolList = List<School>();
    });
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
      _schoolList = List<School>();
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
      _schoolList = List<School>();
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
    _schoolList = List<School>();
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
        _schoolList = List<School>();
      } else {
        _user.fk_nagar_id = null;
        _user.fk_school_id = null;
        _nagarList = List<Nagar>();
        _schoolList = List<School>();
      }
    });
  }

  fetchVidyalay(String id) async {
    Result result = await db.school(id);
    final list = result.data.map<School>((i) => School.fromJson(i)).toList();
    setState(() {
      if (list.length > 0) {
        _schoolList = list;
      } else {
        _user.fk_school_id = null;
        _schoolList = List<School>();
      }
    });
  }

  Widget _schoolNameField() {
    return TextFormField(
      decoration: appStyle.inputDecoration("Enter Name"),
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _user.school_name = value;
      },
    );
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
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select kshetra';
        }
      },
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
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select prant';
        }
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
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select samiti';
        }
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
        // fetchNagar(value);
        fetchVidyalay(value);
        setState(() {
          _user.fk_mahanagar_id = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select district';
        }
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
        fetchVidyalay(value);
        setState(() {
          _user.fk_nagar_id = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select nagar';
        }
      },
      decoration: appStyle.inputDecoration("Select Nagar"),
    );
  }

  Widget _schoolField() {
    return DropdownButtonFormField(
      value: _user.fk_school_id,
      items: _schoolList.map((value) {
        return DropdownMenuItem(
          value: value.school_id,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                value.school_name,
                overflow: TextOverflow.fade,
              )),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        setState(() {
          _user.fk_school_id = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select vidyalay';
        }
      },
      decoration: appStyle.inputDecoration("Select Vidyalay"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Search School",
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
                      child: Text("Get Schools"),
                      onPressed: getNewsList,
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

  Future<List<Widget>> renderControls() async {
    return [
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5.0),
        color: Colors.grey.withOpacity(0.3),
        child: Center(
          child: Text(
            "Search By Name",
            style: TextStyle(fontSize: 20.0, color: Colors.white54),
          ),
        ),
      ),
      _schoolNameField(),
      appStyle.horizontalSpace(),
      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5.0),
          color: Colors.grey.withOpacity(0.3),
          child: Column(
            children: <Widget>[
              Text(
                "OR",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              Text(
                "Search By Location",
                style: TextStyle(fontSize: 20.0, color: Colors.white54),
              ),
            ],
          )),
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
      // _nagarField(),
      // appStyle.horizontalSpace(),
      _schoolField(),
    ];
  }

  getNewsList() async {
    try {
      _regKey.currentState.save();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SchoolListPage(filter: _user),
        ),
      );
    } catch (e) {
      print("Error ::${e.toString()}");
    }
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
