class AppStatus {
  String app_status;
  String message;
  String version;
  String version_message;

  AppStatus({
    this.app_status,
    this.message,
    this.version,
    this.version_message,
  });

  Map<String, dynamic> toJson() {
    return {
      "app_status": app_status.toString(),
      "message": message.toString(),
      "version": version.toString(),
      "version_message": version_message.toString(),
    };
  }

  factory AppStatus.fromJson(Map<String, dynamic> json) {
    return AppStatus(
      app_status: json["app_status"].toString(),
      message: json["message"].toString(),
      version: json["version"].toString(),
      version_message: json["version_message"].toString(),
    );
  }
}
