// ignore_for_file: non_constant_identifier_names

class ProgramType {
  final String group_name;
  final int group_id;
  // ignore: prefer_typing_uninitialized_variables
  var program;

  ProgramType({
    required this.group_name,
    required this.program,
    required this.group_id,
  });

  factory ProgramType.fromJson(Map<String, dynamic> json) {
    //debugPrint([0]['title']);
    return ProgramType(
      program: json['program'],
      group_name: json['group_name'],
      group_id: json['group_id'],
    );
  }
}
