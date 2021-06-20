class NoticeModel {
  String id;
  String pk_ntb_notice_id;
  String post_source;
  String post_device;
  String fk_mum_user_id;
  String fk_usm_user_id;
  String fk_school_id;
  String fk_country_id;
  String fk_kshetra_id;
  String fk_prant_id;
  String fk_department_id;
  String fk_mahanagar_id;
  String fk_nagar_id;
  String notice_date;
  String notice_title;
  String notice_text;
  String notice_attachment;
  String expiry_date;
  String notice_status;
  String ins_date;

  NoticeModel({
    this.id,
    this.pk_ntb_notice_id,
    this.post_source,
    this.post_device,
    this.fk_mum_user_id,
    this.fk_usm_user_id,
    this.fk_school_id,
    this.fk_country_id,
    this.fk_kshetra_id,
    this.fk_prant_id,
    this.fk_department_id,
    this.fk_mahanagar_id,
    this.fk_nagar_id,
    this.notice_date,
    this.notice_title,
    this.notice_text,
    this.notice_attachment,
    this.expiry_date,
    this.notice_status,
    this.ins_date,
  });

  Map<String, dynamic> toJson() {
    return {
      //"id": this.id??"",
      "pk_ntb_notice_id": this.pk_ntb_notice_id??"",
      //"post_source": this.post_source??"",
      //"post_device": this.post_device??"",
      "fk_mum_user_id": this.fk_mum_user_id??"",
      "fk_usm_user_id": this.fk_usm_user_id??"",
      "fk_school_id": this.fk_school_id??"",
      "fk_country_id": this.fk_country_id??"",
      "fk_kshetra_id": this.fk_kshetra_id??"",
      "fk_prant_id": this.fk_prant_id??"",
      "fk_department_id": this.fk_department_id??"",
      "fk_mahanagar_id": this.fk_mahanagar_id??"",
      "fk_nagar_id": this.fk_nagar_id??"",
      "notice_date": this.notice_date??"",
      "notice_title": this.notice_title??"",
      "notice_text": this.notice_text??"",
      "notice_attachment": this.notice_attachment??"",
      //"expiry_date": this.expiry_date??"",
      "notice_status": this.notice_status??"",
      //"ins_date": this.ins_date??"",
    };
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json["id"],
      pk_ntb_notice_id: json["pk_ntb_notice_id"],
      post_source: json["post_source"],
      post_device: json["post_device"],
      fk_mum_user_id: json["fk_mum_user_id"],
      fk_usm_user_id: json["fk_usm_user_id"],
      fk_school_id: json["fk_school_id"],
      fk_country_id: json["fk_country_id"],
      fk_kshetra_id: json["fk_kshetra_id"],
      fk_prant_id: json["fk_prant_id"],
      fk_department_id: json["fk_department_id"],
      fk_mahanagar_id: json["fk_mahanagar_id"],
      fk_nagar_id: json["fk_nagar_id"],
      notice_date: json["notice_date"],
      notice_title: json["notice_title"],
      notice_text: json["notice_text"],
      notice_attachment: json["notice_attachment"],
      expiry_date: json["expiry_date"],
      notice_status: json["notice_status"],
      ins_date: json["ins_date"],
    );
  }
}
