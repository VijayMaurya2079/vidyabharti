class NewsViewDetail {
  String pk_new_news_id;
  String post_date;
  String news_title;
  String news_text;
  String image_path;
  String user_name;
  String transaction_status;
  List<NewsImages> images;
  List<NewsImages> videos;

  NewsViewDetail({
    this.pk_new_news_id = "",
    this.post_date = "",
    this.news_title = "",
    this.news_text = "",
    this.image_path = "",
    this.user_name = "",
    this.transaction_status = "1",
    this.images,
    this.videos,
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_news_id": pk_new_news_id.toString(),
      "post_date": post_date.toString(),
      "news_title": news_title.toString(),
      "news_text": news_text.toString(),
      "image_path": image_path.toString(),
      "user_name": user_name.toString(),
      "transaction_status": transaction_status.toString(),
      //"images": images,
    };
  }

  factory NewsViewDetail.fromJson(Map<String, dynamic> json) {
    return NewsViewDetail(
      pk_new_news_id: json["pk_new_news_id"] ?? "",
      post_date: json["post_date"] ?? "",
      news_title: json["news_title"] ?? "",
      news_text: json["news_text"] ?? "",
      image_path: json["image_path"] ?? "",
      user_name: json["user_name"] ?? "",
      transaction_status: json["transaction_status"].toString() ?? "0",
      images: json["images"]
          .map<NewsImages>((i) => NewsImages.fromJson(i))
          .toList(),
      videos: json["videos"]
          .map<NewsImages>((i) => NewsImages.fromJson(i))
          .toList(),
    );
  }
}

class NewsImages {
  String pk_new_newsimage_id;
  String image_path;
  int is_primary;

  NewsImages({
    this.pk_new_newsimage_id = "",
    this.image_path = "",
    this.is_primary=0,
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_newsimage_id": pk_new_newsimage_id,
      "image_path": image_path,
      "is_primary": is_primary ,
    };
  }

  factory NewsImages.fromJson(Map<String, dynamic> json) {
    return NewsImages(
      pk_new_newsimage_id: json["pk_new_newsimage_id"].toString(),
      image_path: json["image_path"],
      is_primary: json["is_primary"] as int,
    );
  }
}
