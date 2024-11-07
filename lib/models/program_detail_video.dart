// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProgramDetailVideo {
  final String videoId;
  final String title;
  final String published;
  final String image;

  ProgramDetailVideo(
      {required this.videoId,
      required this.title,
      required this.published,
      required this.image});

  factory ProgramDetailVideo.fromJson(Map<String, dynamic> json) {
    return ProgramDetailVideo(
      videoId: json['v'],
      title: json['title'],
      published: json['published'],
      image: json['thumb_attrs_url'],
    );
  }
}
