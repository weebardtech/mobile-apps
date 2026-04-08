import 'dart:convert';

UserListResponse userListDataFromJson(String str) =>
    UserListResponse.fromJson(json.decode(str));

String userListToFromJson(UserListResponse data) => json.encode(data.toJson());

class UserListResponse {
  int statusCode;
  List<EmployeeData> data;
  String message;

  UserListResponse({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      UserListResponse(
        statusCode: json["status_code"],
        data: (json["data"] != null)
            ? List<EmployeeData>.from((json["data"] as List<dynamic>)
                .map((x) => EmployeeData.fromJson(x)))
            : [],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'message': message,
      };
}

class EmployeeData {
  int id;
  // String employeeId;
  // String grade;
  String name;
  // String status;
  String division;
  // String projectName;
  // String projectCode;
  String designation;
  // String mobileNumber;
  // String email;

  EmployeeData({
    required this.id,
    // required this.employeeId,
    // required this.grade,
    required this.name,
    // required this.status,
    required this.division,
    // required this.projectName,
    // required this.projectCode,
    required this.designation,
    // required this.mobileNumber,
    // required this.email,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        id: json["id"] ?? 0,
        // employeeId: json["employeeId"] ?? '',
        //  grade: json["grade"] ?? '',
        name: json["name"] ?? '',
        // status: json["status"] ?? '',
        division: json["division"] ?? '',
        // projectName: json["projectName"] ?? '',
        // projectCode: json["projectCode"] ?? '',
        designation: json["designation"] ?? '',
        // mobileNumber: json["mobileNumber"] ?? '',
        // email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "employeeId": employeeId,
        // "grade": grade,
        "name": name,
        // "status": status,
        "division": division,
        // "projectName": projectName,
        // "projectCode": projectCode,
        "designation": designation,
        // "mobileNumber": mobileNumber,
        // "email": email,
      };
}
