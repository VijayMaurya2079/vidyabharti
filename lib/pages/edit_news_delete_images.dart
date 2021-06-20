import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';

class EditNewsDeleteImages extends StatefulWidget {
  final String id;
  EditNewsDeleteImages({Key key, this.id}) : super(key: key);

  _EditNewsDeleteImagesState createState() => _EditNewsDeleteImagesState();
}

class _EditNewsDeleteImagesState extends State<EditNewsDeleteImages> {
  @override
  void initState() {
    super.initState();
    newsBloc.list(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Delete News Images",
      child: StreamBuilder(
        stream: newsBloc.getNews,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container();
            default:
              return imageGrid(snapshot.data);
          }
        },
      ),
    );
  }

  imageGrid(NewsViewDetail news) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: news.images.length ?? 0,
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
                  child: FadeInImage.assetNetwork(
                    image: news.images[index].image_path,
                    placeholder: "assets/default_image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: -5.0,
                right: 0.0,
                child: IconButton(
                  iconSize: 30.0,
                  icon: Icon(Icons.cancel),
                  onPressed: () =>
                      deleteImage(news.images[index].pk_new_newsimage_id),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  deleteImage(id) async {
    setState(() {
      utill.isLoading = true;
    });
    Result result = await db.deleteNewsImage(id);
    print(result.toJson());
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
            content: Text("Image deleted Successfully"),
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
  }
}
