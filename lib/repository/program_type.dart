import 'dart:convert';
import 'package:app_new/models/program_type.dart';
import 'package:http/http.dart' as http;

class ProgramTypeRepository {
  Future<List<ProgramType>> getProgramType() async {
    try {
      final response = await http
          .get(Uri.parse("https://news.ustv.com.tw/app/program/all_type"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data'];
        return data.map((item) {
          return ProgramType.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
