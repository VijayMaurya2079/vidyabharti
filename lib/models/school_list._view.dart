class SchoolListView {
  String school_id;
  String nagar_name;
  String mahanagar_name;
  String department_name;
  String prant_name;
  String kshetra_name;
  String country_name;
  String school_name;
  String school_address;
  String pin_code;
  String contact_no;
  String school_website;
  String school_email;
  String school_logo;
  String school_latitude;
  String school_longitude;
  String principal_name;
  String principal_contact;
  String principal_msg;
  String principal_image;

  SchoolListView({
    this.school_id = null,
    this.nagar_name = "",
    this.mahanagar_name = "",
    this.department_name = null,
    this.prant_name = null,
    this.kshetra_name = null,
    this.country_name = null,
    this.school_name = null,
    this.school_address = null,
    this.pin_code = null,
    this.contact_no = "",
    this.school_website = null,
    this.school_email = "",
    this.school_logo = "",
    this.school_latitude = "",
    this.school_longitude = "",
    this.principal_name = "",
    this.principal_contact = "",
    this.principal_msg = "",
    this.principal_image = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "school_id": school_id,
      "nagar_name": nagar_name,
      "mahanagar_name": mahanagar_name,
      "department_name": department_name,
      "prant_name": prant_name,
      "kshetra_name": kshetra_name,
      "country_name": country_name,
      "school_name": school_name,
      "school_address": school_address,
      "pin_code": pin_code,
      "contact_no": contact_no,
      "school_website": school_website,
      "school_email": school_email,
      "school_logo": school_logo,
      "school_latitude": school_latitude,
      "school_longitude": school_longitude,
      "principal_name": principal_name,
      "principal_contact": principal_contact,
      "principal_msg": principal_msg,
      "principal_image": principal_image,
    };
  }

  factory SchoolListView.fromJson(Map<String, dynamic> json) {
    return SchoolListView(
      school_id: json["school_id"].toString(),
      nagar_name: json["nagar_name"].toString(),
      mahanagar_name: json["mahanagar_name"].toString(),
      department_name: json["department_name"].toString(),
      prant_name: json["prant_name"].toString(),
      kshetra_name: json["kshetra_name"].toString(),
      country_name: json["country_name"].toString(),
      school_name: json["school_name"].toString(),
      school_address: json["school_address"].toString(),
      pin_code: json["pin_code"].toString(),
      contact_no: json["contact_no"].toString(),
      school_website: json["school_website"].toString(),
      school_email: json["school_email"].toString(),
      school_logo: json["school_logo"].toString(),
      school_latitude: json["school_latitude"].toString(),
      school_longitude: json["school_longitude"].toString(),
      principal_name: json["principal_name"].toString(),
      principal_contact: json["principal_contact"].toString(),
      principal_msg: json["principal_msg"].toString(),
      principal_image: json["principal_image"].toString(),
    );
  }
}
