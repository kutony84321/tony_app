import 'dart:convert';
import 'package:app_new/models/breaking_news.dart';
import 'package:http/http.dart' as http;

class BreakingNewsRepository {
  Future<List<BreakingNews>> getBreakingNews() async {
    try {
      final response = await http.get(
          Uri.parse("https://news.ustv.com.tw/app/instant_messageData/api"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data'];
        return data.map((item) {
          return BreakingNews.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
