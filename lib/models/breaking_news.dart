// ignore_for_file: non_constant_identifier_names

class BreakingNews {
  final String url;
  final String subject;

  BreakingNews({
    required this.subject,
    required this.url,
  });

  factory BreakingNews.fromJson(Map<String, dynamic> json) {
    return BreakingNews(
      url: json['url'],
      subject: json['subject'],
    );
  }
}
