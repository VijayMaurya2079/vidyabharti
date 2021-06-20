class Samiti {
  String department_id;
  String department_name;
  String hindi_name;

  Samiti({
    this.department_id='',
    this.department_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "department_id": department_id,
      "department_name": department_name,
      "hindi_name": hindi_name,
    };
  }

  factory Samiti.fromJson(Map<String, dynamic> json) {
    return Samiti(
      department_id: json["department_id"],
      department_name: json["department_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
