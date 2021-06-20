class NewsUploads {
  String pk_new_newsimage_id;
  String fk_new_news_id;
  String image_type;
  bool is_primary;
  String image_name;
  String image_path;
  String image_text;
  String transaction_status;
  String fk_mum_user_id;

  NewsUploads({
    this.pk_new_newsimage_id = "",
    this.fk_new_news_id = "",
    this.image_type = "Image",
    this.is_primary = false,
    this.image_name = "",
    this.image_path = "",
    this.image_text = "",
    this.transaction_status = "",
    this.fk_mum_user_id = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_newsimage_id": pk_new_newsimage_id,
      "fk_new_news_id": fk_new_news_id,
      "image_type": image_type,
      "is_primary": is_primary.toString(),
      "image_name": image_name,
      "image_path": image_path,
      "image_text": image_text,
      "transaction_status": transaction_status,
      "fk_mum_user_id": fk_mum_user_id,
    };
  }

  factory NewsUploads.fromJson(Map<String, dynamic> json) {
    return NewsUploads(
      pk_new_newsimage_id: json["pk_new_newsimage_id"],
      fk_new_news_id: json["fk_new_news_id"],
      image_type: json["image_type"],
      is_primary: json["is_primary"] as bool,
      image_name: json["image_name"],
      image_path: json["image_path"],
      image_text: json["image_text"],
      transaction_status: json["transaction_status"],
    );
  }
}
