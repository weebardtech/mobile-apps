import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/apis.dart';
import '../models/user_response.dart';

class UserRepository {
  final APIClient apiClient;
  UserRepository(this.apiClient);

  Future<UserResponse> userLogin(String employeeId, String password) async {
    try {
      Response response = await apiClient.dio.post(Apis.user_login,
          data: {"employee_id": employeeId, "password": password});
      if (response.statusCode == 200) {
        final userResponse = userResponseFromJson(json.encode(response.data));
        return userResponse;
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      throw Exception('Something went wrong, Please retry again!');
    }
  }
}
