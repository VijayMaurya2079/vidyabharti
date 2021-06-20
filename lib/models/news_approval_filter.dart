class NewsApprovalFilter {
  String school_name;
  String fk_country_id;
  String fk_kshetra_id;
  String fk_prant_id;
  String fk_department_id;
  String fk_mahanagar_id;
  String fk_nagar_id;
  String fk_school_id;
  String fk_ogs_designation_id;
  String transaction_status;

  NewsApprovalFilter({
    this.school_name = null,
    this.fk_country_id = null,
    this.fk_kshetra_id = null,
    this.fk_prant_id = null,
    this.fk_department_id = null,
    this.fk_mahanagar_id = null,
    this.fk_nagar_id = null,
    this.fk_school_id = null,
    this.fk_ogs_designation_id = null,
    this.transaction_status = "1",
  });

  Map<String, dynamic> toJson() {
    return {
      "school_name": school_name?.toString(),
      "fk_country_id": fk_country_id?.toString(),
      "fk_kshetra_id": fk_kshetra_id?.toString(),
      "fk_prant_id": fk_prant_id?.toString(),
      "fk_department_id": fk_department_id?.toString(),
      "fk_mahanagar_id": fk_mahanagar_id?.toString(),
      "fk_nagar_id": fk_nagar_id?.toString(),
      "fk_school_id": fk_school_id?.toString(),
      "fk_ogs_designation_id": fk_ogs_designation_id?.toString(),
      "transaction_status": transaction_status?.toString(),
    };
  }

  factory NewsApprovalFilter.fromJson(Map<String, dynamic> json) {
    return NewsApprovalFilter(
      school_name: json["school_name"],
      fk_country_id: json["fk_country_id"],
      fk_kshetra_id: json["fk_kshetra_id"],
      fk_prant_id: json["fk_prant_id"],
      fk_department_id: json["fk_department_id"],
      fk_mahanagar_id: json["fk_mahanagar_id"],
      fk_nagar_id: json["fk_nagar_id"],
      fk_school_id: json["fk_school_id"],
      fk_ogs_designation_id: json["fk_ogs_designation_id"],
      transaction_status: json["transaction_status"],
    );
  }
}
