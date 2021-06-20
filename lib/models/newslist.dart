class NewsList {
  String pk_new_news_id;
  String post_date;
  String news_title;
  String image_path;
  String user_name;
  String transaction_status;

  NewsList({
    this.pk_new_news_id,
    this.post_date = '',
    this.news_title = '',
    this.image_path = '',
    this.user_name = '',
    this.transaction_status = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_news_id": pk_new_news_id.toString(),
      "post_date": post_date.toString(),
      "news_title": news_title.toString(),
      "image_path": image_path.toString(),
      "user_name": user_name.toString(),
      "transaction_status": transaction_status.toString(),
    };
  }

  factory NewsList.fromJson(Map<String, dynamic> json) {
    return NewsList(
      pk_new_news_id: json["pk_new_news_id"].toString(),
      post_date: json["post_date"].toString(),
      news_title: json["news_title"].toString(),
      image_path: json["image_path"].toString(),
      user_name: json["user_name"].toString(),
      transaction_status: json["transaction_status"].toString(),
    );
  }
}
