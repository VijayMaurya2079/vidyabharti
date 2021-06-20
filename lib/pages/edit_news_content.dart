import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class EditNewContent extends StatefulWidget {
  final String id;
  EditNewContent(this.id);
  _EditNewContentState createState() => _EditNewContentState();
}

class _EditNewContentState extends State<EditNewContent> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newsBloc.list(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Edit News",
      child: StreamBuilder<NewsViewDetail>(
        stream: newsBloc.getNews,
        builder: (context, AsyncSnapshot<NewsViewDetail> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container();
            default:
              return editContainer(snapshot.data);
          }
        },
      ),
    );
  }

  editContainer(data) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Column(
            children: <Widget>[
              utill.isLoading ? utill.showLoader() : Container(),
              TextFormField(
                initialValue: data.news_title ?? "",
                keyboardType: TextInputType.text,
                maxLines: 3,
                validator: (String value) {
                  if (value.length < 20 || value.length > 200) {
                    return 'News Title must be greater then 20 and less then 200 characters.';
                  }
                },
                onSaved: (value) {
                  data.news_title = value;
                },
                decoration: appStyle.inputDecoration("News Title"),
              ),
              TextFormField(
                initialValue: data.news_text ?? "",
                keyboardType: TextInputType.text,
                maxLines: 15,
                validator: (String value) {
                  if (value.length > 10000) {
                    return 'News Detail must be less then 10000 letters.';
                  }
                },
                onSaved: (value) {
                  data.news_text = value;
                },
                decoration: appStyle.inputDecoration("News Detail, Maximum 10000 letters."),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: RaisedButton(
                  child: Text("Update"),
                  onPressed: () => saveNews(data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveNews(NewsViewDetail data) async {
    setState(() {
      utill.isLoading = true;
    });
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      print("Edit News Data ${data.toJson()}");
      db.updateNews(data).then(
        (Result result) async {
          setState(() {
            utill.isLoading = false;
          });
          if (result.status) {
            newsBloc.list(widget.id);
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Success Message"),
                  content: Text("News updated Successfully"),
                );
              },
            );
          } else {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error Message"),
                  content: Text(result.message),
                );
              },
            );
          }
        },
      );
    } else {
      setState(() {
        utill.isLoading = false;
      });
    }
  }
}
