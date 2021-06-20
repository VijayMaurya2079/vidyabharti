class EditNewsContentView {
  String pk_new_news_id;
  String news_language;
  String news_title;
  String news_text;

  EditNewsContentView({
    this.pk_new_news_id = "",
    this.news_language = "",
    this.news_title = "",
    this.news_text = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_news_id": pk_new_news_id,
      "news_language": news_language,
      "news_title": news_title,
      "news_text": news_text,
    };
  }

  factory EditNewsContentView.fromJson(Map<String, dynamic> json) {
    return EditNewsContentView(
      pk_new_news_id: json["pk_new_news_id"],
      news_language: json["news_language"],
      news_title: json["news_title"],
      news_text: json["news_text"],
    );
  }
}
