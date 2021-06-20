class Nagar {
  String nagar_id;
  String nagar_name;
  String hindi_name;

  Nagar({
    this.nagar_id='',
    this.nagar_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "nagar_id": nagar_id,
      "nagar_name": nagar_name,
      "hindi_name": hindi_name,
    };
  }

  factory Nagar.fromJson(Map<String, dynamic> json) {
    return Nagar(
      nagar_id: json["nagar_id"],
      nagar_name: json["nagar_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
