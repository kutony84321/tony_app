import 'dart:convert';
import 'package:app_new/models/news_list.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class NewsListRepository {
  Future<List<NewsList>> getNewsList({int page = 1, int id = 0}) async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse(
              "https://news.ustv.com.tw/app/news_listdata/api/$id?page=$page"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return NewsList.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'NewsListRepository');
        return [];
      }
    } catch (e) {
      dump('Error: $e', 'NewsListRepository');
      return [];
    }
  }
}
