// ignore_for_file: non_constant_identifier_names

class FoodType {
  final int type_id;
  final int type_name;
  var sub_type;

  FoodType({
    required this.type_id,
    required this.type_name,
    required this.sub_type,
  });

  factory FoodType.fromJson(Map<String, dynamic> json) {
    //debugPrint([0]['title']);
    return FoodType(
      type_id: json['type_id'],
      type_name: json['type_name'],
      sub_type: json['type2'],
    );
  }
}
