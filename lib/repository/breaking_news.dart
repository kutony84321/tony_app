import 'dart:convert';
import 'package:app_new/models/breaking_news.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class BreakingNewsRepository {
  Future<List<BreakingNews>> getBreakingNews() async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse("https://news.ustv.com.tw/app/instant_messageData/api"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data'];
        return data.map((item) {
          return BreakingNews.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'BreakingNewsRepository');
        return [];
      }
    } catch (e) {
      dump('Error: $e', 'BreakingNewsRepository');
      return [];
    }
  }
}
