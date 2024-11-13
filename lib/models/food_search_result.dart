// ignore_for_file: non_constant_identifier_names

class FoodSearchResult {
  final int shop_id;
  final String shop_name;
  final String intro;
  final String address;
  final List<Map<String, dynamic>> tag;
  final String? video;

  FoodSearchResult({
    required this.shop_id,
    required this.shop_name,
    required this.intro,
    required this.address,
    required this.tag,
    required this.video,
  });

  factory FoodSearchResult.fromJson(Map<String, dynamic> json) {
    //debugPrint([0]['title']);
    return FoodSearchResult(
      shop_id: json['shopid'],
      shop_name: json['name'],
      intro: json['media_recommend'],
      tag: [
        {'type': json['type_name'], 'type_id': json['type_id']},
        {'subtype': json['subtype_name'], 'subtype_id': json['sub_type']},
        {'city': json['city'], 'city_id': json['city_code']},
        {'subarea': json['sub_area'], 'subarea_id': json['sub_area_code']}
      ],
      address: json['city'] + json['sub_area'] + json['address'],
      video: json['video'],
    );
  }
}
