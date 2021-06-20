class AdVideos {
  String id;
  String title;
  String path;
  String act_date;

  AdVideos({
    this.id,
    this.title,
    this.path,
    this.act_date,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "path": path,
      "act_date": act_date,
    };
  }

  factory AdVideos.fromJson(Map<String, dynamic> json) {
    return AdVideos(
      id: json["id"],
      title: json["title"],
      path: json["path"],
      act_date: json["act_date"].toString(),
    );
  }
}
