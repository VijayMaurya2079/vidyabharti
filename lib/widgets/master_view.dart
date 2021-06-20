// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/models/ad_video.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/useBloc.dart';
import 'package:vidyabharti/pages/ad_video_list.dart';
import 'package:vidyabharti/pages/add_news.dart';
import 'package:vidyabharti/pages/app_setting.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/pages/change_password.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/pages/documentry_videos.dart';
import 'package:vidyabharti/pages/help.dart';
import 'package:vidyabharti/pages/magazine/magazine.dart';
import 'package:vidyabharti/pages/my_news.dart';
import 'package:vidyabharti/pages/new_approval_filter_news.dart';
import 'package:vidyabharti/pages/news_filter.dart';
import 'package:vidyabharti/pages/notice/NoticeBloc.dart';
import 'package:vidyabharti/pages/notice/NoticeList.dart';
import 'package:vidyabharti/pages/profile.dart';
import 'package:vidyabharti/pages/sangathan/filter.dart';
import 'package:vidyabharti/pages/search_school.dart';
import 'package:vidyabharti/pages/show_adv_video.dart';
import 'package:vidyabharti/pages/social/type_list.dart';
import 'package:vidyabharti/pages/user_list.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';

class AppBody extends StatefulWidget {
  final Widget child;
  final Widget floatingChild;
  final String title;
  final Color color;

  AppBody({
    Key key,
    this.title,
    @required this.child,
    this.floatingChild,
    this.color,
  });

  @override
  _AppBodyState createState() => new _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  String _title;
  String _userName = "";
  //Timer _timer; //_firsTime;

  @override
  void initState() {
    super.initState();
    getUserName();
    _title = widget.title;
    noticeBloc.count();
    // _firsTime = new Timer(new Duration(seconds: 30), () {
    //   showAd();
    //   _firsTime.cancel();
    // });
    //Timer(new Duration(seconds: 30), showAd);
    //Timer.periodic(new Duration(seconds: 30), (Timer t) => showAd);
  }

  getUserName() async {
    String n = await utill.getString("name");
    setState(() {
      _userName = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: widget.color ?? Colors.pink[800],
        elevation: 4.0,
        title: _title == null
            ? defaultTitle()
            : Text(
                _title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                ),
              ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_userName ?? ""),
                StreamBuilder(
                  stream: noticeBloc.getCount,
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return SizedBox();
                      default:
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoticeListPage(),
                              ),
                            );
                          },
                          child: (snapshot.data != "0")
                              ? Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(Icons.notifications_none),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: countWidget("${snapshot.data}"),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        );
                    }
                  },
                ),
                _userName == null
                    ? FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.lock_open, color: Colors.white),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AuthPage()),
                          );
                        },
                      )
                    : SizedBox(),
                _userName == null ? popMenuAnynonmus() : popMenu(),
              ],
            ),
          )
        ],
      ),
      //drawer: AppDrawer(),
      body: Container(
        child: Stack(
          children: <Widget>[
            widget.child,
            utill.isLoading ? utill.showLoader() : Container(),
          ],
        ),
      ),
      floatingActionButton: widget.floatingChild,
    );
  }

  defaultTitle() {
    return Row(
      children: <Widget>[
        Image.asset("assets/icon.png",width: 30),
        FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("विद्या भारती"),
              Text(
                "सा विद्या या विमुक्तये",
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  popMenuAnynonmus() {
    List<CustomPopupMenu> choices = <CustomPopupMenu>[
      CustomPopupMenu(
        id: 1,
        title: 'News',
        icon: Icons.library_books,
        page: DashboardPage(),
      ),
      CustomPopupMenu(
        id: 6,
        title: 'Search School',
        icon: Icons.school,
        page: SearchSchoolNews(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'School Videos',
        icon: Icons.personal_video,
        page: AdVideoList(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Documentary Videos',
        icon: Icons.personal_video,
        page: DocumentoryVideoList(),
      ),
    ];

    return PopupMenuButton<CustomPopupMenu>(
      elevation: 3.2,
      onSelected: (CustomPopupMenu choice) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => choice.page),
        );
      },
      itemBuilder: (BuildContext context) {
        return choices.map((CustomPopupMenu choice) {
          return PopupMenuItem<CustomPopupMenu>(
              value: choice, child: customeListItem(choice));
        }).toList();
      },
    );
  }

  popMenu() {
    List<CustomPopupMenu> choices = <CustomPopupMenu>[
      CustomPopupMenu(
        id: 1,
        title: 'News',
        icon: Icons.library_books,
        page: DashboardPage(),
      ),
      CustomPopupMenu(
        id: 2,
        title: 'My Profile',
        icon: Icons.person,
        page: ProfilePage(),
      ),
      CustomPopupMenu(
        id: 3,
        title: 'Add News',
        icon: Icons.add_box,
        page: AddNews(),
      ),
      CustomPopupMenu(
        id: 4,
        title: 'My News',
        icon: Icons.select_all,
        page: MyNewsListPage(),
      ),
      CustomPopupMenu(
        id: 5,
        title: 'Approve News',
        icon: Icons.check_circle,
        page: NewsApprovalFilterNews(),
      ),
      CustomPopupMenu(
        id: 6,
        title: 'Search School',
        icon: Icons.school,
        page: SearchSchoolNews(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'News Filter',
        icon: Icons.filter_frames,
        page: NewsFilterPage(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'School Videos',
        icon: Icons.personal_video,
        page: AdVideoList(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Documentary Videos',
        icon: Icons.personal_video,
        page: DocumentoryVideoList(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Vidya Bharti Sangathan',
        icon: Icons.person_pin,
        page: SangathanFilterPage("sangathan"),
      ),
      CustomPopupMenu(
        id: 88,
        title: 'Alumni Portal',
        icon: Icons.person_pin,
        page: null,
      ),
      CustomPopupMenu(
        id: 10,
        title: 'Notices',
        icon: Icons.notifications_none,
        page: NoticeListPage(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Approve User',
        icon: Icons.list,
        page: UserListPage(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Seva Prakalp',
        icon: Icons.assistant_photo,
        page: SocialTypeListPage(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Magazine & Periodicals',
        icon: Icons.assistant_photo,
        page: MagazinePage(),
      ),
      CustomPopupMenu(
        id: 7,
        title: 'Notification Setting',
        icon: Icons.notifications,
        page: AppSettingPage(),
      ),
      CustomPopupMenu(
        id: 8,
        title: 'Change Password',
        icon: Icons.vpn_key,
        page: ChangePasswordPage(),
      ),
      CustomPopupMenu(
        id: 9,
        title: 'Log Out',
        icon: Icons.lock,
        page: null,
      ),
      CustomPopupMenu(
        id: 8,
        title: 'Help',
        icon: Icons.help_outline,
        page: HelpPage(),
      ),
    ];

    return PopupMenuButton<CustomPopupMenu>(
      elevation: 3.2,
      onSelected: (CustomPopupMenu choice) {
        if (choice.id == 9) {
          logout();
        }
        if (choice.id == 88) {
          launch("https://vidyabharatialumni.org");
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => choice.page),
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return choices.map((CustomPopupMenu choice) {
          return PopupMenuItem<CustomPopupMenu>(
              value: choice, child: customeListItem(choice));
        }).toList();
      },
    );
  }

  customeListItem(choice) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Icon(
        choice.icon,
        color: Colors.pink,
      ),
      title: Text(choice.title),
    );
  }

  customeListItemWithCount(choice) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Icon(
        choice.icon,
        color: Colors.pink,
      ),
      title: Text(choice.title),
      trailing: StreamBuilder(
        stream: noticeBloc.getCount,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("Notices Count ${snapshot.connectionState}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Text("C 0");
            default:
              return Container(
                child: Text("${snapshot.data.data ?? ''}"),
              );
          }
        },
      ),
    );
  }

  logout() async {
    await utill.deleteLocal("id");
    await utill.deleteLocal("name");
    userBloc.setAppState();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
      (Route<dynamic> route) => false,
    );
  }

  showAd() async {
    print("Advertisement");
    String id = await utill.getString("ad");
    Result result = await db.advideo(id ?? "1");
    AdVideos ad = AdVideos.fromJson(result.data);
    if (result.status) {
      utill.saveString("ad", ad.id);
      showDialog(
        context: context,
        builder: (context) {
          return ShowAdVideo(ad);
        },
      );
    } else {
      //_timer.cancel();
    }
  }

  countWidget(String number) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 15,
        minWidth: 15,
      ),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.orange,
      ),
      child: Text(
        number.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}

class CustomPopupMenu {
  CustomPopupMenu({this.id, this.title, this.icon, this.page});
  int id;
  String title;
  IconData icon;
  Widget page;
}
