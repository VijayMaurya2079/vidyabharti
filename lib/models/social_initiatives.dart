class SocialInitiatives {
  String pk_soc_activity_id;
  String activity_name;
  String activity_description;

  SocialInitiatives({
    this.pk_soc_activity_id = '',
    this.activity_name = '',
    this.activity_description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_soc_activity_id": pk_soc_activity_id,
      "activity_name": activity_name,
      "activity_description": activity_description,
    };
  }

  factory SocialInitiatives.fromJson(Map<String, dynamic> json) {
    return SocialInitiatives(
      pk_soc_activity_id: json["pk_soc_activity_id"],
      activity_name: json["activity_name"],
      activity_description: json["activity_description"],
    );
  }
}

class SocialMedia {
  String pk_soc_activitymedia_id;
  String activity_date;
  String video_path;
  String image_path;
  String media_title;
  String media_content;
  String media_type;

  SocialMedia({
    this.pk_soc_activitymedia_id,
    this.activity_date,
    this.video_path,
    this.image_path,
    this.media_title,
    this.media_content,
    this.media_type,
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_soc_activitymedia_id": pk_soc_activitymedia_id,
      "activity_date": activity_date,
      "video_path": video_path,
      "image_path": image_path,
      "media_title": media_title,
      "media_content": media_content,
      "media_type": media_type,
    };
  }

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      pk_soc_activitymedia_id: json["pk_soc_activitymedia_id"],
      activity_date: json["activity_date"],
      video_path: json["video_path"],
      image_path: json["image_path"],
      media_title: json["media_title"],
      media_content: json["media_content"],
      media_type: json["media_type"],
    );
  }
}
