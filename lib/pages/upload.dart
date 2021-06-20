import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/news_uploads.dart';
import 'package:vidyabharti/models/newslist_block.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:file_picker/file_picker.dart';

class UploadNewsData extends StatefulWidget {
  final String newsId;
  final bool isEdit;
  UploadNewsData(this.newsId, this.isEdit);
  _UploadNewsDataState createState() => _UploadNewsDataState();
}

class _UploadNewsDataState extends State<UploadNewsData> {
  List<NewsUploads> allPaths = [];
  TextEditingController _url1Controller = TextEditingController();
  FocusNode _url1Focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _url1Controller.addListener(() {
      print(_url1Controller.text);
    });
  }

  @override
  void dispose() {
    _url1Controller.dispose();
    _url1Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Upload Media",
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                allPaths.length == 0
                    ? Column(
                        children: <Widget>[
                          Text(
                            "You can select multiple images from your gallery and press any image for a few seconds to make the image primary or icon image of news.",
                            style: TextStyle(
                              height: 1.1,
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          MaterialButton(
                            child: Text("Select Image From Gallery"),
                            onPressed: openGallery,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10.0),
                        ],
                      )
                    : Container(),
                addVideo(),
                SizedBox(height: 10.0),
                Container(
                  height: 500,
                  child: showImages(),
                ),
              ],
            ),
          ),
        ),
      ), //allPaths.length == 0 ? addVideo() : showImages(),
      floatingChild: floatingButton(),
    );
  }

  floatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        allPaths.length > 0
            ? MaterialButton(
                elevation: 6.0,
                color: Colors.greenAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.save),
                    Text("Save Images"),
                  ],
                ),
                onPressed: () {
                  saveImages();
                  saveVideo();
                },
              )
            : Text(""),
        SizedBox(width: 15.0),
        MaterialButton(
          elevation: 6.0,
          color: Colors.yellowAccent,
          child: Row(
            children: <Widget>[
              Icon(Icons.folder_open),
              Text("Open Gallery"),
            ],
          ),
          onPressed: openGallery,
        ),
      ],
    );
  }

  addVideo() {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _url1Controller,
            focusNode: _url1Focus,
            decoration: InputDecoration(
              labelText: "Enter First Youtube Video Code",
              prefix: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Image.network(
                            "http://vidyabhartionline.org/images/youtube_info.png"),
                      );
                    },
                  );
                },
              ),
              suffix: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => saveVideo(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showImages() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: allPaths.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.black.withOpacity(0.5),
                margin: EdgeInsets.all(2.0),
                child: GestureDetector(
                  child: Image.file(
                    File(allPaths[index].image_path),
                    fit: BoxFit.cover,
                  ),
                  onLongPress: () {
                    setState(() {
                      allPaths.forEach((NewsUploads n) {
                        if (n.image_name == allPaths[index].image_name) {
                          allPaths[index].is_primary =
                              !allPaths[index].is_primary;
                        } else {
                          n.is_primary = false;
                        }
                      });
                    });
                  },
                ),
              ),
              Positioned(
                top: -5.0,
                right: 0.0,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      allPaths.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          ),
          footer: allPaths[index].is_primary
              ? Container(
                  padding: EdgeInsets.all(2.0),
                  color: Colors.black,
                  child: Text(
                    "Default Image",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ))
              : Container(),
        );
      },
    );
  }

  openGallery() async {
    allPaths = [];
    String id = await utill.getString("id");
    Map<String, String> filesPaths =
        await FilePicker.getMultiFilePath(type: FileType.image);
    setState(() {
      filesPaths.forEach((k, v) {
        allPaths.add(
          NewsUploads(
            is_primary: false,
            image_path: v,
            image_name: k,
            fk_new_news_id: widget.newsId,
            fk_mum_user_id: id,
          ),
        );
      });
    });
  }

  saveImages() {
    allPaths.forEach(
      (NewsUploads news) async {
        String base64Image =
            base64Encode(File(news.image_path).readAsBytesSync());
        setState(() {
          utill.isLoading = true;
        });
        news.image_name = generateFileName(widget.newsId, news.image_name);
        String status = await db.uploadNewsImage(base64Image, news.image_name);
        if (status == 'Ok') {
          Result result = await db.addNewsImage(news);
          if (result.status) {
            if (!widget.isEdit) {
              setState(() {
                allPaths.remove(news);
                if (allPaths.length == 0) {
                  utill.isLoading = false;
                  newsListBloc.list(0);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                }
              });
            } else {
              newsBloc.list(widget.newsId);
              utill.isLoading = false;
              Navigator.pop(context);
            }
          }
        }
      },
    );
  }

  generateFileName(String id, String fileName) {
    var rng = new Random();
    var ext = (fileName.split('.')).last;
    fileName = id + rng.nextInt(1000).toString() + "." + ext;
    return fileName;
  }

  saveVideo() async {
    if (_url1Controller.text.isNotEmpty) {
      NewsUploads news = NewsUploads();
      utill.isLoading = true;
      news.image_name = _url1Controller.text;
      news.image_path = _url1Controller.text;
      news.fk_new_news_id = widget.newsId;
      news.image_type = "Video";
      Result result = await db.addNewsImage(news);
      if (result.status) {
        _url1Focus.unfocus();
        _url1Controller.text = "";
        utill.isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success Message"),
              content: Text("Video Uploaded Successfully."),
            );
          },
        );
      }
    }
  }
}
