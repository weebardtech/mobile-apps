import 'dart:convert';

ApiStatusResponse apiStatusResponseFromJson(String str) =>
    ApiStatusResponse.fromJson(json.decode(str));

String apiStatusResponseToJson(ApiStatusResponse data) =>
    json.encode(data.toJson());

class ApiStatusResponse {
  int statusCode;
  String message;

  ApiStatusResponse({
    required this.statusCode,
    required this.message,
  });

  factory ApiStatusResponse.fromJson(Map<String, dynamic> json) =>
      ApiStatusResponse(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
