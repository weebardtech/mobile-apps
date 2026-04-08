// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  int statusCode;
  User? user;
  String message;

  UserResponse({
    required this.statusCode,
    required this.user,
    required this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        statusCode: json["status_code"],
        user: json["user"] != null
            ? User.fromJson(json["user"])
            : null,
        message: json["message"],
      );

       Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "user": user?.toJson(),
        "message": message,
      };
}

class User {
  int id;
  int employeeId;
  String projectCode;
  String name;
  String email;

  // String address;
  String mobileNumber;
  String designation;

  String image;

  bool isAdmin;
  String apiToken;
  String departmentName;
  String role;

  User({
    required this.id,
    required this.employeeId,
    required this.projectCode,
    required this.name,
    required this.email,
    // required this.address,
    required this.mobileNumber,
    required this.designation,
    required this.image,
    required this.isAdmin,
    required this.apiToken,
    required this.departmentName,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employeeId: json["employee_id"],
        projectCode: json["project_code"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        // address: json["address"],
        mobileNumber: json["mobile_number"] ?? '',
        departmentName: json["department_name"],
        role: json["role"],
        designation: json["designation"],
        image: json["image"],
        isAdmin: json["is_admin"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "project_code": projectCode,
        "name": name,
        "email": email,
        // "address": address,
        "mobile_number": mobileNumber,
        "department_name": departmentName,
        "role": role,
        "designation": designation,
        "image": image,
        "is_admin": isAdmin,
        "api_token": apiToken,
      };
}
