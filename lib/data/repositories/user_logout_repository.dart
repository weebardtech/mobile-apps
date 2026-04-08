import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/apis.dart';
import '../models/user_logout_response.dart';

class UserLogoutRepository {
  final APIClient apiClient;

  UserLogoutRepository(this.apiClient);

  Future<UserLogoutResponse> postUserLogout(String apiToken) async {
    try {
      Response response = await apiClient.dio.post(
        Apis.logout,
        queryParameters: {"api_token": apiToken},
      );

      if (response.statusCode == 200) {
        return UserLogoutResponse.fromJson(response.data);
      } else {
        // Handle non-200 status codes here
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      throw Exception('Failed to Logout: $e');
    }
  }
}
