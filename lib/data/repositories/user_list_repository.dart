import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/apis.dart';
import '../models/user_list_response.dart';

class UserListRepository {
  final APIClient apiClient;

  UserListRepository(this.apiClient);

  Future<UserListResponse> GetUserList(String apiToken, String keyword) async {
    try {
      Response response = await apiClient.dio.get(Apis.user_list,
          queryParameters: {"api_token": apiToken, "keyword": keyword});
      if (response.statusCode == 200) {
        final userResponse = userListDataFromJson(json.encode(response.data));
        return userResponse;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Exception error: $e');
    }
  }
}
