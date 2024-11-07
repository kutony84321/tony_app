import 'dart:convert';
import 'package:app_new/models/news_list.dart';
import 'package:http/http.dart' as http;

class NewsListRepository {
  Future<List<NewsList>> getNewsList({int page = 1, int id = 0}) async {
    try {
      final response = await http.get(Uri.parse(
          "https://news.ustv.com.tw/app/news_listdata/api/$id?page=$page"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return NewsList.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
