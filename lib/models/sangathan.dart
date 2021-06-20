class SangathanModel {
  String pk_ogs_sangathan_id;
  String person_name;
  String designation_name;
  String mahanagar_name;
  String profile_pdf;
  String mobile_no;
  String alternate_no;
  String email_id;
  String profile_image;

  SangathanModel({
    this.pk_ogs_sangathan_id,
    this.person_name,
    this.designation_name,
    this.mahanagar_name,
    this.profile_pdf,
    this.mobile_no,
    this.alternate_no,
    this.email_id,
    this.profile_image,
  });

  Map<String, dynamic> toJson() {
    return {
      "pk_ogs_sangathan_id": pk_ogs_sangathan_id,
      "person_name": person_name,
      "designation_name": designation_name,
      "mahanagar_name": mahanagar_name,
      "profile_pdf": profile_pdf,
      "mobile_no": mobile_no,
      "alternate_no": alternate_no,
      "email_id": email_id,
      "profile_image": profile_image,
    };
  }

  factory SangathanModel.fromJson(Map<String, dynamic> json) {
    return SangathanModel(
      pk_ogs_sangathan_id: json["pk_ogs_sangathan_id"],
      person_name: json["person_name"],
      designation_name: json["designation_name"],
      mahanagar_name: json["mahanagar_name"],
      profile_pdf: json["profile_pdf"],
      mobile_no: json["mobile_no"],
      alternate_no: json["alternate_no"],
      email_id: json["email_id"],
      profile_image: json["profile_image"],
    );
  }
}
