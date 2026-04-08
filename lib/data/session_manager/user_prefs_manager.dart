import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_response.dart';

class UserPrefsManager {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final String token = "api_token";
  final String userName = "user_name";
  final String email = "user_email";
  final String mobile = "mobile_number";
  final String notificationEnable = "notification_enable";
  final String image = "user_image";
  final String departmentName = "department_name";

  Future<bool> hasToken() async {
    var value = await storage.read(key: token);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    var value = await storage.read(key: token);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }

  Future<String> getUserName() async {
    var value = await storage.read(key: userName);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }



  Future<String> getProfileImage() async {
    var value = await storage.read(key: image);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }

  Future<String> getEmail() async {
    var value = await storage.read(key: email);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }

  Future<String> getDepartmentName() async {
    var value = await storage.read(key: departmentName);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }



  Future<String> getMobile() async {
    var value = await storage.read(key: mobile);

    if (value!.isNotEmpty) {
      return value;
    } else {
      return "";
    }
  }

  Future<bool> hasNotification() async {
    var value = await storage.read(key: notificationEnable);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setNotificationState(bool isEnabled) async {
    try {
      await storage.write(key: notificationEnable, value: isEnabled.toString());
    } catch (e) {
      // print('Error setting notification state: $e');
      throw e;
    }
  }

  Future<bool> getNotificationState() async {
    var value = await storage.read(key: notificationEnable);
    if (value != null) {
      return value.toLowerCase() == 'true';
    } else {
      return false; // Return false if the value is not stored previously
    }
  }

  Future<void> setUserInfo(User user) async {
    try {
      // Execute storage write operations concurrently
      await Future.wait([
        storage.write(key: token, value: user.apiToken),
        storage.write(key: userName, value: user.name),
        storage.write(key: email, value: user.email),
        storage.write(key: mobile, value: user.mobileNumber),
        storage.write(key: image, value: user.image),
        storage.write(key: departmentName, value: user.departmentName),
      ]);
    } catch (e) {
      // Handle errors appropriately
      // print('Error setting user info: $e');
      throw e;
    }
  }

  // Store a boolean value
  void storeFirstIntro(bool value) async {
    await storage.write(key: 'is_first_intro', value: value.toString());
  }

  Future<bool> isFirstIntroPreview() async {
    String? stringValue = await storage.read(key: 'is_first_intro');
    if (stringValue != null) {
     // return stringValue.toLowerCase() == 'true';
      if(stringValue.toLowerCase() == 'true'){
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<void> deleteToken() async {
    storage.deleteAll();
  }
}
