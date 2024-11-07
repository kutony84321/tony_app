import 'dart:convert';
import 'package:app_new/models/program_detail_video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProgramDetailVideoRepository {
  Future<List<ProgramDetailVideo>> getProgramDetailVideo(
      {int page = 1, int program_id = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          "https://news.ustv.com.tw/app/program/api/videodata?id=$program_id&page=$page"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return ProgramDetailVideo.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
