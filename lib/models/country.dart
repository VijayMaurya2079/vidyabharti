class Country {
  String country_id;
  String country_name;
  String hindi_name;

  Country({
    this.country_id='',
    this.country_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "country_id": country_id,
      "country_name": country_name,
      "hindi_name": hindi_name,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country_id: json["country_id"],
      country_name: json["country_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
