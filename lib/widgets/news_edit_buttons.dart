import 'package:flutter/material.dart';
import 'package:vidyabharti/pages/edit_news_content.dart';
import 'package:vidyabharti/pages/edit_news_delete_images.dart';
import 'package:vidyabharti/pages/upload.dart';

class NewsEditButtons extends StatelessWidget {
  final String pk_new_news_id;

  NewsEditButtons(this.pk_new_news_id);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Material(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNewContent( pk_new_news_id),
                    ),
                  ),
            ),
          ),
          Material(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadNewsData(
                            pk_new_news_id,
                            true,
                          ),
                    ),
                  ),
            ),
          ),
          Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete_sweep,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditNewsDeleteImages(id: pk_new_news_id),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
