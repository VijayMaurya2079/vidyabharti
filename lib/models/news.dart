class News {
  String pk_new_news_id;
  String post_date;
  String post_source;
  String post_device;
  String web_title;
  String meta_tags;
  String web_description;
  String fk_mum_user_id;
  String fk_usm_user_id;
  String news_language;
  String news_category;
  String news_level;
  String fk_school_id;
  String fk_country_id;
  String fk_prant_id;
  String fk_department_id;
  String fk_mahanagar_id;
  String fk_nagar_id;
  String news_title;
  String news_text;
  String news_approved_by;
  String approval_date;
  String transaction_status;

  News({
    this.pk_new_news_id = "",
    this.post_date = "",
    this.post_source = "School",
    this.post_device = "Mobile",
    this.web_title = "",
    this.meta_tags = "",
    this.web_description = "",
    this.fk_mum_user_id = "",
    this.fk_usm_user_id = "",
    this.news_language = "English",
    this.news_category = "",
    this.news_level = "",
    this.fk_school_id = "",
    this.fk_country_id = "",
    this.fk_prant_id = "",
    this.fk_department_id = "",
    this.fk_mahanagar_id = "",
    this.fk_nagar_id = "",
    this.news_title = "",
    this.news_text = "",
    this.news_approved_by = "",
    this.approval_date = "",
    this.transaction_status = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_new_news_id": pk_new_news_id,
      "post_date": post_date,
      "post_source": post_source,
      "post_device": post_device,
      "web_title": web_title,
      "meta_tags": meta_tags,
      "web_description": web_description,
      "fk_mum_user_id": fk_mum_user_id,
      "fk_usm_user_id": fk_usm_user_id,
      "news_language": news_language,
      "news_category": news_category,
      "news_level": news_level,
      "fk_school_id": fk_school_id,
      "fk_country_id": fk_country_id,
      "fk_prant_id": fk_prant_id,
      "fk_department_id": fk_department_id,
      "fk_mahanagar_id": fk_mahanagar_id,
      "fk_nagar_id": fk_nagar_id,
      "news_title": news_title,
      "news_text": news_text,
      "news_approved_by": news_approved_by,
      "approval_date": approval_date,
      "transaction_status": transaction_status,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      pk_new_news_id: json["pk_new_news_id"],
      post_date: json["post_date"],
      post_source: json["post_source"],
      post_device: json["post_device"],
      web_title: json["web_title"],
      meta_tags: json["meta_tags"],
      web_description: json["web_description"],
      fk_mum_user_id: json["fk_mum_user_id"],
      fk_usm_user_id: json["fk_usm_user_id"],
      news_language: json["news_language"],
      news_category: json["news_category"],
      news_level: json["news_level"],
      fk_school_id: json["fk_school_id"],
      fk_country_id: json["fk_country_id"],
      fk_prant_id: json["pk_prant_id"],
      fk_department_id: json["fk_department_id"],
      fk_mahanagar_id: json["fk_mahanagar_id"],
      fk_nagar_id: json["fk_nagar_id"],
      news_title: json["news_title"],
      news_text: json["news_text"],
      news_approved_by: json["news_approved_by"],
      approval_date: json["approval_date"],
      transaction_status: json["transaction_status"],
    );
  }
}
