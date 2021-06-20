class Distict {
  String mahanagar_id;
  String mahanagar_name;
  String hindi_name;

  Distict({
    this.mahanagar_id='',
    this.mahanagar_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "mahanagar_id": mahanagar_id,
      "mahanagar_name": mahanagar_name,
      "hindi_name": hindi_name,
    };
  }

  factory Distict.fromJson(Map<String, dynamic> json) {
    return Distict(
      mahanagar_id: json["mahanagar_id"],
      mahanagar_name: json["mahanagar_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
