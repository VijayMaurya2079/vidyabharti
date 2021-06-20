class ChangePassword {
  String user_email_id;
  String new_password;
  String password;

  ChangePassword({
    this.user_email_id='',
    this.new_password = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "user_email_id": user_email_id,
      "new_password": new_password,
      "password": password,
    };
  }

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      user_email_id: json["user_email_id"],
      new_password: json["new_password"],
      password: json["password"],
    );
  }
}
