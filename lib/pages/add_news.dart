import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidyabharti/models/news.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/upload.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController _controllerTitle = new TextEditingController();
  TextEditingController _controllerDetail = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _news = News();
  int _count = 0;
  int _countTitle = 0;

  @override
  void initState() {
    super.initState();
    _controllerTitle.addListener(() {
      setState(() {
        _countTitle = _controllerTitle.text.length;
      });
    });
    _controllerDetail.addListener(() {
      setState(() {
        _count = _controllerDetail.text.length;
      });
    });
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Add News",
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: Column(
              children: <Widget>[
                utill.isLoading ? utill.showLoader() : Container(),
                DropdownButtonFormField(
                  value: _news.news_language == null
                      ? "English"
                      : _news.news_language,
                  items: ["English", "Hindi"].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _news.news_language = value;
                    });
                  },
                  decoration: appStyle.inputDecoration("News Language"),
                ),
                TextFormField(
                  controller: _controllerTitle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  validator: (String value) {
                    if (value.length < 20 || value.length > 200) {
                      return 'News Title must be greater then 20 and less then 200 characters.';
                    }
                  },
                  onSaved: (value) {
                    _news.news_title = value;
                  },
                  decoration: appStyle.inputDecorationWithCount(
                    "News Title,Min 50 Max 200 Letters",
                    _countTitle,
                    200,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                ),
                TextFormField(
                  controller: _controllerDetail,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 15,
                  validator: (String value) {
                    if (value.length > 10000) {
                      return 'News Detail must be less then 10000 letters.';
                    }
                  },
                  onSaved: (value) {
                    _news.news_text = value;
                  },
                  decoration: appStyle.inputDecorationWithCount(
                    "News Detail, Maximum 10000 letters",
                    _count,
                    2000,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2000),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .95,
                  child: RaisedButton(
                    child: Text("Submit"),
                    onPressed: saveNews,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveNews() async {
    setState(() {
      utill.isLoading = true;
    });
    _formKey.currentState.save();
    _news.fk_mum_user_id = _news.fk_usm_user_id = await utill.getString("id");
    if (_formKey.currentState.validate()) {
      db.addNews(_news).then((Result result) async {
        setState(() {
          utill.isLoading = false;
        });
        if (result.status) {
          _formKey.currentState.reset();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Message"),
                content: Text("News posted Successfully"),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("Upload Media"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UploadNewsData(
                              result.data,
                              false,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Return"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("News alert"),
                content: Text(result.message),
              );
            },
          );
        }
      });
    } else {
      setState(() {
        utill.isLoading = false;
      });
    }
  }
}
