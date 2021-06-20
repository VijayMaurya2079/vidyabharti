import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/models/notice_model.dart';
import 'package:vidyabharti/pages/notice/NoticeBloc.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/master_view.dart';

class NoticeDetailPage extends StatefulWidget {
  final NoticeModel notice;
  NoticeDetailPage(this.notice);
  @override
  _NoticeDetailPageState createState() => new _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  @override
  void initState() {
    super.initState();
    markRead();
    noticeBloc.count();
    noticeBloc.noticeList();
  }

  Future markRead() async {
    await db.noticemarkread(widget.notice);
  }

  @override
  Widget build(BuildContext context) {
    noticeBloc.count();
    return AppBody(
      title: "Noticeboard",
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.notice.notice_title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(widget.notice.notice_date ?? ''),
                    Text(
                      widget.notice.fk_mum_user_id ?? '',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.0,
              child: Container(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text(widget.notice.notice_text)),
            ),
            checkFile(widget.notice.notice_attachment)
                ? FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.attach_file),
                        Text("Notice PDF "),
                      ],
                    ),
                    onPressed: () {
                      launch(widget.notice.notice_attachment);
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  checkFile(String file) {
    final ext = file.split(".").last;
    if (ext == "pdf") {
      return true;
    } else {
      return false;
    }
  }
}
