class Designation {
  String designation_id;
  String designation_name;
  String hindi_name;

  Designation({
    this.designation_id='',
    this.designation_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "designation_id": designation_id,
      "designation_name": designation_name,
      "hindi_name": hindi_name,
    };
  }

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      designation_id: json["designation_id"],
      designation_name: json["designation_name"],
      //hindi_name: json["hindi_name"],
    );
  }
}
