import 'dart:convert';
import 'package:app_new/models/food_type.dart';
import 'package:http/http.dart' as http;
import 'package:app_new/repository/get_token.dart';
import 'package:app_new/function.dart';

class FoodTypeRepository {
  Future<List<FoodType>> getFoodType() async {
    String deviceId = await getDeviceUniqueId();
    String? token = await getToken(deviceId);
    try {
      final response = await http.get(
          Uri.parse("https://news.ustv.com.tw/app/food/api/get_all_type"),
          headers: {
            'Content-Type': 'application/json',
            'X-Authorization': token.toString()
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> data = result['data'];
        return data.map((item) {
          return FoodType.fromJson(item);
        }).toList();
      } else {
        dump('Failed to load result', 'FoodTypeRepository');
        return [];
      }
    } catch (e) {
      dump('Error: $e', 'FoodTypeRepository');
      return [];
    }
  }
}
