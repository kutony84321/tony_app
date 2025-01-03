// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:app_new/models/program_detail_video.dart';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class ProgramDetailVideoRepository {
  Future<List<ProgramDetailVideo>> getProgramDetailVideo(
      {int page = 1, int program_id = 1}) async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse(
              "https://news.ustv.com.tw/app/program/api/videodata?id=$program_id&page=$page"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return ProgramDetailVideo.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'ProgramDetailVideoRepository');
        return [];
        //throw Exception('Failed to load result');
      }
    } catch (e) {
      dump('Error: $e', 'ProgramDetailVideoRepository');
      return [];
      //return Future.error('連線錯誤');
    }
  }
}
