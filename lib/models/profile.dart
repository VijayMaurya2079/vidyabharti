class ProfileView {
  String pk_mum_user_id;
  String user_name;
  String fk_nagar_id;
  String fk_mahanagar_id;
  String school_name;
  String profile_image;
  String user_designation;
  String user_mobile_no;
  String user_email_id;
  String user_gender;
  String primary_language;

  ProfileView({
    this.pk_mum_user_id = "",
    this.user_name = '',
    this.school_name = '',
    this.fk_mahanagar_id = '',
    this.fk_nagar_id = '',
    this.profile_image = "",
    this.user_designation = "",
    this.user_mobile_no = "",
    this.user_email_id = "",
    this.user_gender = "",
    this.primary_language = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_mum_user_id": pk_mum_user_id.toString(),
      "user_name": user_name.toString(),
      "school_name": school_name.toString(),
      "fk_mahanagar_id": fk_mahanagar_id.toString(),
      "fk_nagar_id": fk_nagar_id.toString(),
      "profile_image": profile_image.toString(),
      "user_designation": user_designation.toString(),
      "user_mobile_no": user_mobile_no.toString(),
      "user_email_id": user_email_id.toString(),
      "user_gender": user_gender.toString(),
      "primary_language": primary_language.toString(),
    };
  }

  factory ProfileView.fromJson(Map<String, dynamic> json) {
    return ProfileView(
      pk_mum_user_id: json["pk_mum_user_id"] as String,
      user_name: json["user_name"] as String,
      school_name: (json["school_name"] ?? "") as String,
      fk_mahanagar_id: (json["fk_mahanagar_id"] ?? "") as String,
      fk_nagar_id: json["fk_nagar_id"] as String,
      profile_image: json["profile_image"] as String,
      user_designation: json["user_designation"] as String,
      user_mobile_no: json["user_mobile_no"] as String,
      user_email_id: json["user_email_id"] as String,
      user_gender: json["user_gender"] as String,
      primary_language: json["primary_language"] as String,
    );
  }
}
