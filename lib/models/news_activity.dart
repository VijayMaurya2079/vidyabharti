class NewsActivity {
  String pk_new_news_activity_id;
  String activity_date;
  String activity_source;
  String activity_type;
  String social_sharing_site;
  String fk_new_news_id;
  String user_name;
  String user_email;
  String user_mobile;
  String fk_mum_user_id;
  String news_comment;
  String transaction_status;

  NewsActivity({
    this.pk_new_news_activity_id = "",
    this.activity_date = "",
    this.activity_source = "",
    this.activity_type = "",
    this.social_sharing_site = "",
    this.fk_new_news_id = "",
    this.user_name = "",
    this.user_email = "",
    this.user_mobile = "",
    this.fk_mum_user_id = "",
    this.news_comment = "",
    this.transaction_status = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_news_activity_id": pk_new_news_activity_id??"",
      "activity_date": activity_date??"",
      "activity_source": activity_source??"",
      "activity_type": activity_type??"",
      "social_sharing_site": social_sharing_site??"",
      "fk_new_news_id": fk_new_news_id??"",
      "user_name": user_name??"",
      "user_email": user_email??"",
      "user_mobile": user_mobile??"",
      "fk_mum_user_id": fk_mum_user_id??"",
      "news_comment": news_comment??"",
      "transaction_status": transaction_status??"",
    };
  }

  factory NewsActivity.fromJson(Map<String, dynamic> json) {
    return NewsActivity(
      pk_new_news_activity_id: json["pk_new_news_activity_id"],
      activity_date: json["activity_date"],
      activity_source: json["activity_source"],
      activity_type: json["activity_type"],
      social_sharing_site: json["social_sharing_site"],
      fk_new_news_id: json["fk_new_news_id"],
      user_name: json["user_name"],
      user_email: json["user_email"],
      user_mobile: json["user_mobile"],
      fk_mum_user_id: json["fk_mum_user_id"],
      news_comment: json["news_comment"],
      transaction_status: json["transaction_status"],
    );
  }
}
