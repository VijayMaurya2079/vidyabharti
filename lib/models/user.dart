class UserLogin {
  String user_email_id;
  String user_name;
  String password;

  UserLogin({
    this.user_email_id,
    this.user_name = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "user_email_id": user_email_id,
      "user_name": user_name,
      "password": password,
    };
  }

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      user_email_id: json["user_email_id"],
      user_name: json["user_name"],
      password: json["password"],
    );
  }
}
