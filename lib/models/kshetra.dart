class Kshetra {
  String kshetra_id;
  String kshetra_name;
  String hindi_name;

  Kshetra({
    this.kshetra_id='',
    this.kshetra_name = '',
    this.hindi_name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "kshetra_id": kshetra_id,
      "kshetra_name": kshetra_name,
      "hindi_name": hindi_name,
    };
  }

  factory Kshetra.fromJson(Map<String, dynamic> json) {
    return Kshetra(
      kshetra_id: json["kshetra_id"],
      kshetra_name: json["kshetra_name"],
      hindi_name: json["hindi_name"],
    );
  }
}
