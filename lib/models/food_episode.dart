// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

class FoodEpisode {
  final int episode_id;
  final int episode_number;
  final String date;
  final String subject;
  final String intro;
  final String video_id;
  var shop;

  FoodEpisode({
    required this.episode_id,
    required this.episode_number,
    required this.date,
    required this.subject,
    required this.intro,
    required this.video_id,
    required this.shop,
  });

  factory FoodEpisode.fromJson(Map<String, dynamic> json) {
    //debugPrint([0]['title']);
    if (json['video'] == null || json['video'] == "") {
      json['video'] = "";
    }
    return FoodEpisode(
      episode_id: json['sid'],
      episode_number: json['no'],
      date: json['date'],
      subject: json['subject'],
      intro: json['intro'],
      video_id: json['video'],
      shop: json['shop'],
    );
  }
}
