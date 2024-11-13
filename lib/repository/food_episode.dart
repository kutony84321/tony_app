import 'dart:convert';
import 'package:app_new/models/food_episode.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class FoodEpisodeRepository {
  Future<List<FoodEpisode>> getFoodEpisode() async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse("https://news.ustv.com.tw/app/food/api/get_all_episode"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data'];
        return data.map((item) {
          return FoodEpisode.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'FoodEpisodeRepository');
        return [];
      }
    } catch (e) {
      dump('Error: $e', 'FoodEpisodeRepository');
      return [];
    }
  }
}
