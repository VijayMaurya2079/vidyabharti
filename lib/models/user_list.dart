class UserListView {
  String pk_mum_user_id;
  String user_name;
  String user_designation;
  String user_mobile_no;
  String user_email_id;
  String user_gender;
  String school_name;
  String kshetra_name;
  String prant_name;
  String profile_image;
  String mahanagar_name;

  UserListView({
    this.pk_mum_user_id = "",
    this.user_name = '',
    this.school_name = '',
    this.mahanagar_name = '',
    this.prant_name = '',
    this.profile_image = "",
    this.user_designation = "",
    this.user_mobile_no = "",
    this.user_email_id = "",
    this.user_gender = "",
    this.kshetra_name = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_mum_user_id": pk_mum_user_id.toString(),
      "user_name": user_name.toString(),
      "school_name": school_name.toString(),
      "mahanagar_name": mahanagar_name.toString(),
      "prant_name": prant_name.toString(),
      "profile_image": profile_image.toString(),
      "user_designation": user_designation.toString(),
      "user_mobile_no": user_mobile_no.toString(),
      "user_email_id": user_email_id.toString(),
      "user_gender": user_gender.toString(),
      "kshetra_name": kshetra_name.toString(),
    };
  }

  factory UserListView.fromJson(Map<String, dynamic> json) {
    return UserListView(
      pk_mum_user_id: json["pk_mum_user_id"] as String,
      user_name: json["user_name"] as String,
      school_name: (json["school_name"] ?? "") as String,
      mahanagar_name: (json["mahanagar_name"] ?? "") as String,
      prant_name: json["prant_name"] as String,
      profile_image: json["profile_image"] as String,
      user_designation: json["user_designation"] as String,
      user_mobile_no: json["user_mobile_no"] as String,
      user_email_id: json["user_email_id"] as String,
      user_gender: json["user_gender"] as String,
      kshetra_name: json["kshetra_name"] as String,
    );
  }
}
