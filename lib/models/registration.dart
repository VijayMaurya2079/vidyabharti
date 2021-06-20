class User {
  String pk_mum_user_id;
  String registration_date;
  String user_name;
  String fk_country_id;
  String fk_kshetra_id;
  String fk_prant_id;
  String fk_department_id;
  String fk_mahanagar_id;
  String fk_nagar_id;
  String fk_school_id;
  String profile_image;
  String user_designation;
  String user_mobile_no;
  String user_email_id;
  String user_gender;
  String primary_language;
  String otp_code;

  User({
    this.pk_mum_user_id = null,
    this.registration_date = "",
    this.user_name = "",
    this.fk_country_id = null,
    this.fk_kshetra_id = null,
    this.fk_prant_id = null,
    this.fk_department_id = null,
    this.fk_mahanagar_id = null,
    this.fk_nagar_id = null,
    this.fk_school_id = null,
    this.profile_image = "",
    this.user_designation = null,
    this.user_mobile_no = "",
    this.user_email_id = "",
    this.user_gender = "",
    this.primary_language = "Hindi",
    this.otp_code = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_mum_user_id": pk_mum_user_id ?? "",
      "registration_date": registration_date ?? "",
      "user_name": user_name ?? "",
      "fk_country_id": fk_country_id ?? "",
      "fk_kshetra_id": fk_kshetra_id ?? "",
      "fk_prant_id": fk_prant_id ?? "",
      "fk_department_id": fk_department_id ?? "",
      "fk_mahanagar_id": fk_mahanagar_id ?? "",
      "fk_nagar_id": fk_nagar_id ?? "",
      "fk_school_id": fk_school_id ?? "",
      "profile_image": profile_image ?? "",
      "user_designation": user_designation ?? "",
      "user_mobile_no": user_mobile_no ?? "",
      "user_email_id": user_email_id ?? "",
      "user_gender": user_gender ?? "",
      "primary_language": primary_language ?? "Hindi",
      "otp_code": otp_code ?? "",
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pk_mum_user_id: json["pk_mum_user_id"].toString(),
      registration_date: json["registration_date"].toString(),
      user_name: json["user_name"].toString(),
      fk_country_id: json["fk_country_id"].toString(),
      fk_kshetra_id: json["fk_kshetra_id"].toString(),
      fk_prant_id: json["fk_prant_id"].toString(),
      fk_department_id: json["fk_department_id"].toString(),
      fk_mahanagar_id: json["fk_mahanagar_id"].toString(),
      fk_nagar_id: json["fk_nagar_id"].toString(),
      fk_school_id: json["fk_school_id"].toString(),
      profile_image: json["profile_image"].toString(),
      user_designation: json["user_designation"].toString(),
      user_mobile_no: json["user_mobile_no"].toString(),
      user_email_id: json["user_email_id"].toString(),
      user_gender: json["user_gender"].toString(),
      primary_language: json["primary_language"],
      otp_code: json["otp_code"],
    );
  }
}
