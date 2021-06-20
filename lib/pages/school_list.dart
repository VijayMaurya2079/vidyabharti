import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/school_list_bloc.dart';
import 'package:vidyabharti/pages/school_detail.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class SchoolListPage extends StatefulWidget {
  final NewsApprovalFilter filter;
  SchoolListPage({Key key, this.filter}) : super(key: key);

  _SchoolListPageState createState() => _SchoolListPageState();
}

class _SchoolListPageState extends State<SchoolListPage> {
  @override
  void initState() {
    super.initState();
    schoolListBloc.list(widget.filter);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "School List",
      child: Container(
        decoration: appStyle.authBox(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: StreamBuilder(
            stream: schoolListBloc.getSchools,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                default:
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return SchoolDetailPage(
                                school: snapshot.data[index],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: 3.0),
                          color: Colors.white.withOpacity(0.7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  snapshot.data[index].school_name
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  snapshot.data[index].department_name
                                      .toString(),
                                ),
                              ),
                              Container(
                                child: Text(
                                    "${snapshot.data[index].prant_name} > ${snapshot.data[index].mahanagar_name} > ${snapshot.data[index].nagar_name}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
