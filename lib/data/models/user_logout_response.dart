import 'dart:convert';

UserLogoutResponse userLogoutResponseFromJson(String str) =>
    UserLogoutResponse.fromJson(json.decode(str));

String userLogoutResponseToJson(UserLogoutResponse data) =>
    json.encode(data.toJson());

class UserLogoutResponse {
  int statusCode;
  String message;

  UserLogoutResponse({
    required this.statusCode,
    required this.message,
  });

  factory UserLogoutResponse.fromJson(Map<String, dynamic> json) =>
      UserLogoutResponse(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
