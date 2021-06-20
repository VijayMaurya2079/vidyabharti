import 'package:flutter/material.dart';

class NoNews extends StatelessWidget {
  final String newsId;
  const NoNews({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: "primary_image" + newsId,
            child: Container(
              height: 220.0,
              color: Colors.black,
              child: Image.asset(
                "assets/default_image.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 250.0,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
