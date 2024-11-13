// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:app_new/models/food_search_result.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class FoodSearchResultRepository {
  Future<List<FoodSearchResult>> getFoodSearchResult(
      {int page = 1,
      String city_code = '',
      String subarea_id = '',
      String type_id = '',
      String subtype_id = '',
      String text = ''}) async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse(
              "https://news.ustv.com.tw/app/food/api/search?search_type=text&city=$city_code&cityarea=$subarea_id&typeid=$type_id&$subtype_id=88&text=$text"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data']['data'];
        return data.map((item) {
          return FoodSearchResult.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'FoodSearchResultRepository');
        return [];
      }
    } catch (e) {
      dump('Error: $e', 'FoodSearchResultRepository');
      return [];
    }
  }
}
