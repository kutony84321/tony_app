// ignore_for_file: non_constant_identifier_names

class NewsList {
  final String newsid;
  final String subject;
  final String web_text;
  final String news_image;
  final String start_datetime;
  final String newshead;

  NewsList({
    required this.newsid,
    required this.subject,
    required this.web_text,
    required this.news_image,
    required this.start_datetime,
    required this.newshead,
  });

  factory NewsList.fromJson(Map<String, dynamic> json) {
    return NewsList(
      newsid: json['newsid'],
      subject: json['subject'],
      web_text: json['web_text'],
      news_image: json['news_image'],
      start_datetime: json['start_datetime'],
      newshead: json['newshead'],
    );
  }
}
