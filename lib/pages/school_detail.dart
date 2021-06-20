import 'package:flutter/material.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/school_images.dart';
import 'package:vidyabharti/models/school_list._view.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SchoolDetailPage extends StatefulWidget {
  final SchoolListView school;
  SchoolDetailPage({Key key, this.school}) : super(key: key);
  _SchoolDetailPageState createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  getSchoolImage() async {
    Result result = await db.schoolImage(widget.school.school_id);
    final list =
        result.data.map<SchoolImages>((i) => SchoolImages.fromJson(i)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getSchoolImage(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return noImage();
                    default:
                      return snapshot.data.length > 0
                          ? sliderImages(snapshot.data)
                          : noImage();
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 5.0,
                      right: 5.0,
                    ),
                    child: Text(
                      widget.school.school_name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Material(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FadeInImage.assetNetwork(
                                image: widget.school.principal_image,
                                placeholder: "assets/user.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            widget.school.principal_name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(widget.school.principal_contact),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Principal Message",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          widget.school.principal_msg,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Address",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.school_address),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "PIN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.pin_code),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Kshetra",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.kshetra_name),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Prant",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.prant_name),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Distict",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.mahanagar_name),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Contact",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.contact_no),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.school_email),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Website",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(widget.school.school_website),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  noImage() {
    return sliderImages(
      [
        SchoolImages(
          name:
              "http://www.vidyabhartionline.org/images/default_images/school.jpg",
        ),
      ],
    );
  }

  sliderImages(List<SchoolImages> list) {
    return CarouselSlider(
      height: 250.0,
      items: list.map(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 200.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: FadeInImage.assetNetwork(
                  image: i.name,
                  placeholder:
                      "http://www.vidyabhartionline.org/images/default_images/school.jpg",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
