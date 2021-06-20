class NewsActivities {
  int comments;
  int like;
  int dislike;

  NewsActivities({
    this.comments = 0,
    this.like = 0,
    this.dislike = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "comments": comments,
      "like": like,
      "dislike": dislike,
    };
  }

  factory NewsActivities.fromJson(Map<String, dynamic> json) {
    return NewsActivities(
      comments: json["comments"],
      like: json["like"],
      dislike: json["dislike"],
    );
  }
}
