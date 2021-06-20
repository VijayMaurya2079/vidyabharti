import 'package:flutter/material.dart';
import 'package:vidyabharti/models/country.dart';
import 'package:vidyabharti/models/designation.dart';
import 'package:vidyabharti/models/distict.dart';
import 'package:vidyabharti/models/kshetra.dart';
import 'package:vidyabharti/models/nagar.dart';
import 'package:vidyabharti/models/prant.dart';
import 'package:vidyabharti/models/registration.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/samiti.dart';
import 'package:vidyabharti/models/school.dart';
import 'package:vidyabharti/pages/registration_complete.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/style.dart';

class RegisterUser extends StatefulWidget {
  final String temp;
  RegisterUser(this.temp);
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _user = User();
  final _regKey = GlobalKey<FormState>();
  List<Designation> _designationList = List<Designation>();
  List<Country> _countryList = List<Country>();
  List<Kshetra> _kshetraList = List<Kshetra>();
  List<Prant> _prantList = List<Prant>();
  List<Samiti> _samitiList = List<Samiti>();
  List<Distict> _distictList = List<Distict>();
  List<Nagar> _nagarList = List<Nagar>();
  List<School> _schoolList = List<School>();

  @override
  void initState() {
    // fetchCountry();
    fetchKshetra("C1");
    fetchDesignation();
    super.initState();
  }

  fetchDesignation() async {
    Result result = await db.designation();
    final list =
        result.data.map<Designation>((i) => Designation.fromJson(i)).toList();
    setState(() {
      _designationList = list;
    });
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
        //fetchNagar(value);
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
                value.school_name.length > 100
                    ? value.school_name.substring(0, 100)
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

  Widget _nameField() {
    return TextFormField(
      decoration: appStyle.inputDecoration("Enter Name"),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please enter a name';
        }
      },
      onSaved: (String value) {
        _user.user_name = value;
      },
    );
  }

  Widget _designationField() {
    return DropdownButtonFormField(
      value: _user.user_designation,
      items: _designationList.map((value) {
        return DropdownMenuItem(
          value: value.designation_id,
          child: Text(value.designation_name),
        );
      }).toList(),
      hint: Text(""),
      onChanged: (value) {
        setState(() {
          _user.user_designation = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please select designation';
        }
      },
      decoration: appStyle.inputDecoration("Select Designation"),
    );
  }

  Widget _mobileNoField() {
    return TextFormField(
      decoration: appStyle.inputDecoration("Enter Mobile Number"),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return 'Please enter a Mobile number';
        } else if (value.length < 10) {
          return 'Invalid Mobile number';
        }
      },
      onSaved: (String value) {
        _user.user_mobile_no = value;
      },
    );
  }

  Widget _emailIdField() {
    return TextFormField(
      decoration: appStyle.inputDecoration("Enter Email ID"),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _user.user_email_id = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height+200,
          decoration: appStyle.authBox(),
          child: Form(
            key: _regKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 100.0, bottom: 20.0),
                    child: Text(
                      "Register As a New User",
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
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              getFields(),
                            ],
                          ),
                          utill.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
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

  getFields() {
    switch (widget.temp) {
      case "1":
        return Column(
          children: <Widget>[
            _nameField(),
            appStyle.horizontalSpace(),
            _mobileNoField(),
            appStyle.horizontalSpace(),
            _emailIdField(),
            appStyle.horizontalSpace(),
            submitButton(),
            SizedBox(height: 150),
          ],
        );
      case "2":
        return Column(
          children: <Widget>[
            _kshetraField(),
            appStyle.horizontalSpace(),
            _nameField(),
            appStyle.horizontalSpace(),
            _mobileNoField(),
            appStyle.horizontalSpace(),
            _emailIdField(),
            appStyle.horizontalSpace(),
            submitButton(),
            SizedBox(height: 100),
          ],
        );
      case "3":
        return Column(
          children: <Widget>[
            _kshetraField(),
            appStyle.horizontalSpace(),
            _prantField(),
            appStyle.horizontalSpace(),
            _nameField(),
            appStyle.horizontalSpace(),
            _mobileNoField(),
            appStyle.horizontalSpace(),
            _emailIdField(),
            appStyle.horizontalSpace(),
            submitButton(),
            SizedBox(height: 100),
          ],
        );
      case "4":
        return Column(
          children: <Widget>[
            _kshetraField(),
            appStyle.horizontalSpace(),
            _prantField(),
            appStyle.horizontalSpace(),
            _distictField(),
            appStyle.horizontalSpace(),
            _nameField(),
            appStyle.horizontalSpace(),
            _mobileNoField(),
            appStyle.horizontalSpace(),
            _emailIdField(),
            appStyle.horizontalSpace(),
            submitButton(),
          ],
        );
      default:
        return Column(
          children: <Widget>[
            _kshetraField(),
            appStyle.horizontalSpace(),
            _prantField(),
            appStyle.horizontalSpace(),
            _distictField(),
            appStyle.horizontalSpace(),
            _schoolField(),
            appStyle.horizontalSpace(),
            _nameField(),
            appStyle.horizontalSpace(),
            _mobileNoField(),
            appStyle.horizontalSpace(),
            _emailIdField(),
            appStyle.horizontalSpace(),
            submitButton(),
          ],
        );
    }
  }

  submitButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: MaterialButton(
        color: Colors.red,
        textColor: Colors.white70,
        child: Text("Submit"),
        onPressed: registerUser,
      ),
    );
  }

  registerUser() async {
    try {
      _regKey.currentState.save();
      if (_regKey.currentState.validate()) {
        setState(() {
          utill.isLoading = true;
        });
        switch (widget.temp) {
          case "1":
            _user.user_designation = "DG1";
            break;
          case "2":
            _user.user_designation = "DG2";
            break;
          case "3":
            _user.user_designation = "DG3";
            break;
          case "4":
            _user.user_designation = "DG4";
            break;
          case "5":
            _user.user_designation = "DG5";
            break;
          case "6":
            _user.user_designation = "DG6";
            break;
          case "7":
            _user.user_designation = "DG7";
            break;
          case "8":
            _user.user_designation = "DG8";
            break;
          case "9":
            _user.user_designation = "DG9";
            break;
          default:
            _user.user_designation = "";
        }
        _user.user_designation = "";
        Result result = await db.addUser(_user);
        print("Response :: ${result.toJson()}");
        setState(() {
          utill.isLoading = false;
        });
        if (result.status) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationComplete(
                    email: _user.user_email_id,
                    password: result.message,
                  ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Registration Alert"),
                content: Text(result.message),
              );
            },
          );
        }
      }
    } catch (e) {
      print(_user.toJson());
      print("Error ${e.toString()}");
      setState(
        () {
          utill.isLoading = false;
        },
      );
    }
  }

  dropdownItemText(String text) {
    return SizedBox(
      width: 200,
      child: Text(
        text ?? "",
        overflow: TextOverflow.fade,
      ),
    );
  }
}

// _countryField(),
// appStyle.horizontalSpace(),
// _kshetraField(),
// appStyle.horizontalSpace(),
// _prantField(),
// appStyle.horizontalSpace(),
// _samitiField(),
// appStyle.horizontalSpace(),
// _distictField(),
// appStyle.horizontalSpace(),
// _nagarField(),
// appStyle.horizontalSpace(),
// _schoolField(),
// appStyle.horizontalSpace(),
// _nameField(),
// appStyle.horizontalSpace(),
// _designationField(),
// appStyle.horizontalSpace(),
// _mobileNoField(),
// appStyle.horizontalSpace(),
// _emailIdField(),
