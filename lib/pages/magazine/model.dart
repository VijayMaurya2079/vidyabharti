class Magazine {
  String pkMgzMnameId;
  String englishName;
  String coverPageImage;
  String magazinePdf;
  String insDate;

  Magazine({
    this.pkMgzMnameId,
    this.englishName,
    this.coverPageImage,
    this.magazinePdf,
    this.insDate,
  });

  Magazine.fromJson(Map<String, dynamic> json) {
    pkMgzMnameId = json['pk_mgz_mname_id'] ?? "";
    englishName = json['english_name'] ?? "";
    coverPageImage = json['cover_page_image'] ?? "";
    magazinePdf = json['magazine_pdf'] ?? "";
    insDate = json['ins_date'].toString() ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_mgz_mname_id'] = this.pkMgzMnameId ?? "";
    data['english_name'] = this.englishName ?? "";
    data['cover_page_image'] = this.coverPageImage ?? "";
    data['magazine_pdf'] = this.magazinePdf ?? "";
    return data;
  }
}
