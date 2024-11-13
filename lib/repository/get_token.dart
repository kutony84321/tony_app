import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:app_new/function.dart';

const String baseUrl = 'https://news.ustv.com.tw/app';
const String createRefreshToken = '$baseUrl/auth/create_refresh_token';
const String refreshToken = '$baseUrl/auth/refresh_token';
const String verifyToken = '$baseUrl/auth/verify_token';

Future<Map<String, String>> getDeviceIdAndToken() async {
  String deviceId = await getDeviceUniqueId();
  String? token = await getToken(deviceId);
  return {'deviceId': deviceId, 'token': token.toString()};
}

Future<String> getDeviceUniqueId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceId = prefs.getString('deviceId');
  if (deviceId == null) {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Android 的唯一識別碼
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor!; // iOS 的唯一識別碼
    }
    await prefs.setString('deviceId', deviceId.toString());
  }
  return deviceId.toString();
  //throw Exception("Unsupported platform");
}

Future<String?> getToken(String deviceId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  // 檢查 token 是否存在
  if (token == null) {
    // 沒有 token，透過 createRefreshToken API 取得並儲存
    token = await _createToken(deviceId);
    if (token != null) {
      await prefs.setString('token', token);
    }
  } else {
    // 有 token，透過 verifyToken API 檢查有效性
    bool isValid = await _verifyToken(deviceId, token);
    if (!isValid) {
      // Token 無效，重新取得並更新
      token = await _refreshToken(deviceId);
      if (token != null) {
        await prefs.setString('token', token);
      }
    }
  }
  return token;
}

// 使用 createRefreshToken API 取得 token
Future<String?> _createToken(String deviceId) async {
  try {
    final response = await http.post(
      Uri.parse(createRefreshToken),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'decive_id': deviceId.toString()}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final String status = result['status'];
      final Map<String, dynamic> data = result['data'];
      if (status == 'success') {
        String token = data['token'];
        dump(token, '_createToken ');
        return token;
      } else {
        dump(data['message'], '_createToken');
      }
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final Map<String, dynamic> data = result['data'];
      dump(data['message'], '_createToken 401');
    }
  } catch (e) {
    dump("Error in createToken: $e");
  }
  return null;
}

// 使用 verifyToken API 檢查 token 是否有效
Future<bool> _verifyToken(String deviceId, String token) async {
  try {
    final response = await http.post(
      Uri.parse(verifyToken),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-Authorization': token
      },
      body: ({'decive_id': deviceId.toString()}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final String status = result['status'];
      final Map<String, dynamic> data = result['data'];
      if (status == 'success') {
        return true;
      } else {
        dump(data['message'], '_verifyToken');
      }
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final Map<String, dynamic> data = result['data'];
      dump(data['message'], '_verifyToken 401');
    }
  } catch (e) {
    dump("Error in verifyToken: $e");
  }
  return false;
}

// 使用 refreshToken API 重新取得 token
Future<String?> _refreshToken(String deviceId) async {
  try {
    final response = await http.post(
      Uri.parse(refreshToken),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'decive_id': deviceId.toString()}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final String status = result['status'];
      final Map<String, dynamic> data = result['data'];
      if (status == 'success') {
        String token = data['token'];
        dump(token, '_refreshToken success');
        return token;
      } else {
        dump(data['message'], '_refreshToken');
      }
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      final Map<String, dynamic> data = result['data'];
      dump(data['message'], '_refreshToken 401');
    }
  } catch (e) {
    dump("Error in refreshToken: $e");
  }
  return null;
}
