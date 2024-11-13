// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

class FoodCity {
  final int city_code;
  final String city_name;
  var suba_area;

  FoodCity({
    required this.city_code,
    required this.city_name,
    required this.suba_area,
  });

  factory FoodCity.fromJson(Map<String, dynamic> json) {
    //debugPrint([0]['title']);
    return FoodCity(
      city_code: json['city_code'],
      city_name: json['city'],
      suba_area: json['suba_area'],
    );
  }
}
