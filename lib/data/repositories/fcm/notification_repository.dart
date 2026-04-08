import 'dart:convert';

import 'package:dio/dio.dart';

import '../../api/api_client.dart';
import '../../api/apis.dart';
import '../../models/api_status_response.dart';

class NotificationRepository {
  final APIClient apiClient;

  NotificationRepository(this.apiClient);

  Future<ApiStatusResponse> sendNotification(
      String apiToken, String deviceToken) async {
    try {
      Response response = await apiClient.dio.post(
        Apis.firebase_notification,
        queryParameters: {"api_token": apiToken, "device_token": deviceToken},
      );

      if (response.statusCode == 200) {
        final changePasswordResponse =
            apiStatusResponseFromJson(json.encode(response.data));
        return changePasswordResponse;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
