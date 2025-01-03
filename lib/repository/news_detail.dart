import 'dart:convert';
import 'package:app_new/models/news_detail.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
//import 'package:app_new/function.dart';

class NewsDetailRepository {
  Future<NewsDetail> getNewsDetail({String? newsid}) async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse("https://news.ustv.com.tw/app/news_detail/api/$newsid"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final data = NewsDetail.fromJson(result['data']['detail']);
        return data;
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
