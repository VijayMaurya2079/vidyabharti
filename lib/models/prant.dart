class Prant {
  String prant_id;
  String prant_name;
  String hindi_name;

  Prant({
    this.prant_id,
    this.prant_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "prant_id": prant_id,
      "prant_name": prant_name,
      "hindi_name": hindi_name,
    };
  }

  factory Prant.fromJson(Map<String, dynamic> json) {
    return Prant(
      prant_id: json["prant_id"],
      prant_name: json["prant_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
