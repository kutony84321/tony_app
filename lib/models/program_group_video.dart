// ignore_for_file: non_constant_identifier_names

class ProgramGroupVideo {
  final String videoId;
  final String title;
  final String published;
  final String image;
  final String program_name;

  ProgramGroupVideo(
      {required this.videoId,
      required this.title,
      required this.published,
      required this.image,
      required this.program_name});

  factory ProgramGroupVideo.fromJson(Map<String, dynamic> json) {
    return ProgramGroupVideo(
      videoId: json['v'],
      title: json['title'],
      published: json['published'],
      image: json['thumb_attrs_url'],
      program_name: json['p_name'],
    );
  }
}
