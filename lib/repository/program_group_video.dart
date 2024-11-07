import 'dart:convert';
import 'package:app_new/models/program_group_video.dart';
import 'package:http/http.dart' as http;

class ProgramGroupVideoRepository {
  Future<List<ProgramGroupVideo>> getProgramGroupVideo(
      {int page = 1, int group_id = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          "https://news.ustv.com.tw/app/program_last10Data/api/$group_id?page=$page"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return ProgramGroupVideo.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
