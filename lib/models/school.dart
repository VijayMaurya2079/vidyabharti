class School {
  String school_id;
  String school_name;
  String hindi_name;

  School({
    this.school_id='',
    this.school_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "school_id": school_id,
      "school_name": school_name,
      "hindi_name": hindi_name,
    };
  }

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      school_id: json["school_id"],
      school_name: json["school_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
