import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidyabharti/models/change_password.dart';
import 'package:vidyabharti/models/news.dart';
import 'package:vidyabharti/models/news_activity.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_uploads.dart';
import 'package:vidyabharti/models/notice_model.dart';
import 'package:vidyabharti/models/profile.dart';
import 'package:vidyabharti/models/registration.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/user.dart';
import 'package:vidyabharti/pages/magazine/model.dart';
import 'package:vidyabharti/provider/utill.dart';

class DB {
  final String base_url = "http://www.api.vidyabhartionline.org/v5/index.php/";
  // final String base_url = "https://34.93.97.26/api/v5/index.php/";
  String securityCode = "";

  Future<String> token() async {
    var response = await http.get(
      base_url + "token",
    );
    print("${response.body}");
    final responseJson = json.decode(response.body);

    return responseJson["token"];
  }

  Future<String> help() async {
    var response = await http.get(
      base_url + "help",
    );
    return json.decode(response.body);
  }

  Future<String> share() async {
    var response = await http.get(
      base_url + "share",
    );
    return json.decode(response.body);
  }

  Future<Result> adVideoList() async {
    var response = await http.post(
      base_url + "advideolist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> adVideoListPageWise(page) async {
    var response = await http.get(
      base_url + "advideolist/$page",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> documentryVideoList() async {
    var response = await http.post(
      base_url + "documentryvideolist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> documentryVideoListPageWise(page) async {
    var response = await http.get(
      base_url + "documentryvideolist/$page",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> advideo(String id) async {
    var response = await http.post(
      base_url + "advideo",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> appstatus() async {
    var response = await http.post(
      base_url + "appstatus",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> country() async {
    var response = await http.post(
      base_url + "country",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> designation() async {
    var response = await http.post(
      base_url + "designation",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> kshetra(String id) async {
    var response = await http.post(
      base_url + "kshetra",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> prant(String id) async {
    var response = await http.post(
      base_url + "prant",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> samiti(String id) async {
    var response = await http.post(
      base_url + "department",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> distict(String id) async {
    var response = await http.post(
      base_url + "mahanagar",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> nagar(String id) async {
    var response = await http.post(
      base_url + "nagar",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> school(String id) async {
    var response = await http.post(
      base_url + "school",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  //user level
  Future<Result> usercountry() async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/country",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userdesignation() async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/designation",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userkshetra(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/kshetra",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userprant(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/prant",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> usersamiti(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/department",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userdistict(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/mahanagar",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> usernagar(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/nagar",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userschool(String id) async {
    String uid = await utill.getString("id");
    var response = await http.post(
      base_url + "user/school",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id, "uid": uid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

//User level end

  Future<Result> login(UserLogin reg) async {
    var response = await http.post(
      base_url + "login",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: reg.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> changePassword(ChangePassword reg) async {
    var response = await http.post(
      base_url + "change_password",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: reg.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> forgotPassword(String email) async {
    var response = await http.post(
      base_url + "forgot_password",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"email": email},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> addUser(User reg) async {
    var response = await http.post(
      base_url + "adduser",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: reg.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> getUserLevel(String id) async {
    var response = await http.post(
      base_url + "userlevel",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> getUserDetail(String id) async {
    var response = await http.post(
      base_url + "userdetail",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> editUserDetail(String id) async {
    var response = await http.post(
      base_url + "edituserdetail",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> updateUserDetail(ProfileView pv) async {
    var response = await http.post(
      base_url + "updateuserdetail",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: pv.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> userList(String id, String status) async {
    var response = await http.post(
      base_url + "userlist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"fk_mum_user_id": id, "status": status},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> activateUser(String id) async {
    var response = await http.post(
      base_url + "activateuser",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> deleteUser(String id) async {
    var response = await http.post(
      base_url + "deleteuser",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<String> uploadProfileImage(String base64Image, String fileName) async {
    var response = await http.post(
      "http://www.vidyabhartionline.org/images/profile_image/upload.php",
      body: {
        "image": base64Image,
        "name": fileName,
      },
    );
    return response.body;
  }

  Future<Result> addNews(News reg) async {
    var response = await http.post(
      base_url + "addnews",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: reg.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> addNewsImage(NewsUploads newsUploads) async {
    var response = await http.post(
      base_url + "uploadnewsfile",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: newsUploads.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> updateNews(NewsViewDetail news) async {
    var response = await http.post(
      base_url + "updatenews",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: news.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<String> uploadNewsImage(String base64Image, String fileName) async {
    var response = await http.post(
      "http://www.vidyabhartionline.org/images/news_images/upload.php",
      body: {
        "image": base64Image,
        "name": fileName,
      },
    );
    return response.body;
  }

  Future<Result> deleteNewsImage(String id) async {
    var response = await http.post(
      base_url + "deletenewsimage",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> newsList(int page) async {
    var response = await http.post(
      base_url + "newslist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"page": page.toString()},
    );
    print("Page Number From API $page");
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> filterNewsList(NewsApprovalFilter filter) async {
    var response = await http.post(
      base_url + "filternewslist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: filter.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> myNewsList(id, status) async {
    var response = await http.post(base_url + "mynews",
        headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
        body: {"id": id, "status": status});
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> newsDetail(String newsid) async {
    print("News ID :: $newsid");
    var response = await http.post(
      base_url + "newsdetail",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": newsid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> addNewsActivities(NewsActivity act) async {
    var response = await http.post(
      base_url + "addnewsactivity",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: act.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> newsActivities(String newsid) async {
    var response = await http.post(
      base_url + "getnewsactivity",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": newsid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> newsComments(String newsid) async {
    var response = await http.post(
      base_url + "getnewscomments",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": newsid},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> approveNewsList(NewsApprovalFilter user) async {
    var response = await http.post(
      base_url + "approval_newslist",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: user.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> approve(id) async {
    var response = await http.post(
      base_url + "approval",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> disapprove(id) async {
    var response = await http.post(
      base_url + "disapproval",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> deletenews(id) async {
    var response = await http.post(
      base_url + "deletenews",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> changeLevel(id, level) async {
    var response = await http.post(
      base_url + "change_level",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"pk_new_news_id": id, "news_level": level},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> newsActivity(NewsActivity newsActivity) async {
    var response = await http.post(
      base_url + "addnewsactivity",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: newsActivity.toString(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  // School API
  Future<Result> searchSchool(NewsApprovalFilter filter) async {
    print(filter.toJson());
    var response = await http.post(
      base_url + "filter_school",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: filter.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> schoolImage(String id) async {
    var response = await http.post(
      base_url + "school_image",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  sendPush(title, body, id) async {
    http.post(
      'https://fcm.googleapis.com/fcm/send',
      body: json.encode({
        'notification': {'body': '$body', 'title': '$title'},
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '$id',
          'status': 'done',
        },
        'to': '/topics/news',
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=AIzaSyB6euuZjo4LTtPCz_pyZ7gtwCeIsKklp9k',
      },
    );
  }

  //Social API
  Future<Result> socialTypes() async {
    var response = await http.post(
      base_url + "social/type",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> socialdata(String type) async {
    var response = await http.post(
      base_url + "social/data",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"type": type},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  //Sangathan API
  Future<Result> sangathanTypes() async {
    var response = await http.post(
      base_url + "sangathan/type",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> sangathandata(NewsApprovalFilter filter) async {
    var response = await http.post(base_url + "sangathan/data",
        headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
        body: filter.toJson());
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  //Contact API
  Future<Result> contactdata(NewsApprovalFilter filter) async {
    var response = await http.post(
      base_url + "contact/data",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: filter.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  //Notice API
  Future<Result> noticeadd(NoticeModel notice) async {
    print("${notice.toJson()}");
    var response = await http.post(
      base_url + "notice/add",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: notice.toJson(),
    );
    final responseJson = json.decode(response.body);
    final result = Result.fromJson(responseJson);
    print("${result.toJson()}");
    return Result.fromJson(responseJson);
  }

  Future<String> uploadPDF(String path, String fileName) async {
    if (path == null || path == "") {
      return Future.value("");
    } else {
      final _file = base64Encode(File(path).readAsBytesSync());

      var response = await http.post(
        "http://www.vidyabhartionline.org/images/notice/upload.php",
        body: {
          "image": _file,
          "name": fileName,
        },
      );
      return response.body;
    }
  }

  Future<Result> noticelist() async {
    final id = await utill.getString("id");
    var response = await http.post(
      base_url + "notice/list",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"fk_mum_user_id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> noticeread(NoticeModel notice) async {
    var response = await http.post(
      base_url + "notice/read",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: notice.toJson(),
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> noticecount() async {
    final id = await utill.getString("id");
    var response = await http.post(
      base_url + "notice/count",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: {"fk_mum_user_id": id},
    );
    final responseJson = json.decode(response.body);
    return Result.fromJson(responseJson);
  }

  Future<Result> noticemarkread(NoticeModel notice) async {
    final id = await utill.getString("id");
    notice.fk_mum_user_id = id;
    var response = await http.post(
      base_url + "notice/read",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: notice.toJson(),
    );
    final responseJson = json.decode(response.body);
    final result = Result.fromJson(responseJson);
    print("${result.toJson()}");
    return Result.fromJson(responseJson);
  }

  Future<Result> magazineList() async {
    var response = await http.post(
      base_url + "magazine/list",
      headers: {HttpHeaders.authorizationHeader: "Bearer $securityCode"},
      body: "",
    );
    final responseJson = json.decode(response.body);
    final result = Result.fromJson(responseJson);
    print("${result.toJson()}");
    return Result.fromJson(responseJson);
  }

  Future<Result> magazine(Magazine magazine) async {
    var response = await http.post(
      base_url + "magazine",
      body: magazine.toJson(),
    );
    final responseJson = json.decode(response.body);
    print("Done   ");
    return Result.fromJson(responseJson);
  }
}

final db = DB();
