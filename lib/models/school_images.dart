class SchoolImages {
  String name;

  SchoolImages({
    this.name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }

  factory SchoolImages.fromJson(Map<String, dynamic> json) {
    return SchoolImages(
      name: json["name"],
    );
  }
}
