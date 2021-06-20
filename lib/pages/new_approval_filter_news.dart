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
import 'package:vidyabharti/pages/news_approval_news_list.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class NewsApprovalFilterNews extends StatefulWidget {
  @override
  _NewsApprovalFilterNewsState createState() => _NewsApprovalFilterNewsState();
}

class _NewsApprovalFilterNewsState extends State<NewsApprovalFilterNews> {
  String _level = "";
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
    getDefaultData();
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

  getDefaultData() async {
    String _userid = await utill.getString("id");
    Result result = await db.getUserLevel(_userid);
    fetchCountry();
    setState(() {
      _level = result.data;
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
        if (value == null || value.isEmpty) {
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
        if (value == null || value.isEmpty) {
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
        if (value == null || value.isEmpty) {
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
        fetchVidyalay(value);
        //fetchNagar(value);
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
                value.school_name.length > 30
                    ? value.school_name.substring(0, 30)
                    : value.school_name,
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

//user level controls

  fetchUserCountry() async {
    Result result1 = await db.usercountry();
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

  fetchUserKshetra(String id) async {
    Result result = await db.userkshetra(id);
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

  fetchUserPrant(String id) async {
    Result result = await db.userprant(id);
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

  prantUserChange(value) {
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

  fetchUserSamiti(String id) async {
    Result result = await db.usersamiti(id);
    final list = result.data.map<Samiti>((i) => Samiti.fromJson(i)).toList();
    setState(() {
      _samitiList = list;
    });
  }

  fetchUserDistict(String id) async {
    Result result = await db.userdistict(id);
    final list = result.data.map<Distict>((i) => Distict.fromJson(i)).toList();
    setState(() {
      _distictList = list;
    });
  }

  fetchUserNagar(String id) async {
    Result result = await db.usernagar(id);
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

  fetchUserVidyalay(String id) async {
    Result result = await db.userschool(id);
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

  //user level controls
  Widget _userCountryField() {
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
        fetchUserKshetra(value);
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

  Widget _userKshetraField() {
    return DropdownButtonFormField(
      value: _user.fk_kshetra_id,
      items: _kshetraList.map((value) {
        return DropdownMenuItem(
          value: value.kshetra_id,
          child: Text(value.kshetra_name),
        );
      }).toList(),
      onChanged: (value) {
        fetchUserPrant(value);
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

  Widget _userPrantField() {
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
        prantUserChange(value);
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

  Widget _userSamitiField() {
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

  Widget _userDistictField() {
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
        fetchUserNagar(value);
        setState(() {
          _user.fk_mahanagar_id = value;
          _user.fk_school_id = null;
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

  Widget _userNagarField() {
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
        fetchUserVidyalay(value);
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

  Widget _userSchoolField() {
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

  Widget _submitButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: MaterialButton(
        color: Colors.red,
        textColor: Colors.white70,
        child: Text("Get News"),
        onPressed: getNewsList,
      ),
    );
  }

//user level controls end
  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Filter News",
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
                  // _countryField(),
                  // appStyle.horizontalSpace(),
                  // _userKshetraField(),
                  // appStyle.horizontalSpace(),
                  // _prantField(),
                  // appStyle.horizontalSpace(),
                  // _submitButton(),
                  FutureBuilder(
                    future: renderControls(),
                    builder: (context, controls) {
                      return Column(
                        children: controls.data,
                      );
                    },
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
    switch (_level) {
      case "Country":
        return [
          _userCountryField(),
          appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      case "Kshetra":
        return [
          _userCountryField(),
          appStyle.horizontalSpace(),
          _kshetraField(),
          appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      case "Prant":
        return [
          _countryField(),
          appStyle.horizontalSpace(),
          _userKshetraField(),
          appStyle.horizontalSpace(),
          _prantField(),
          appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      case "Mahanager":
        return [
          _countryField(),
          appStyle.horizontalSpace(),
          _kshetraField(),
          appStyle.horizontalSpace(),
          _prantField(),
          appStyle.horizontalSpace(),
          _samitiField(),
          appStyle.horizontalSpace(),
          _userDistictField(),
          appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      case "Nagar":
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
          // _userNagarField(),
          // appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      case "School":
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
          // _nagarField(),
          // appStyle.horizontalSpace(),
          _userSchoolField(),
          appStyle.horizontalSpace(),
          _submitButton(),
        ];
        break;
      default:
        return [
          Container(
            height: 250,
            child: Center(
                child: Text(
              "Sorry, you are not authorized to approve any news",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
          ),
        ];
    }
  }

  getNewsList() async {
    try {
      _regKey.currentState.save();
      if (_regKey.currentState.validate()) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsApprovalNewsListPage(_user),
          ),
        );
      } else {
        print("Invalid");
      }
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
