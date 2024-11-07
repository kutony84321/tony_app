import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String ytId;
  final bool autoplay;
  const VideoPlayer({super.key, required this.ytId, required this.autoplay});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController youtubeController;

  @override
  void initState() {
    super.initState();
    youtubeController = YoutubePlayerController(
      initialVideoId: widget.ytId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoplay,
        //mute: true,
      ),
    );
  }

  @override
  void dispose() {
    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      width: double.infinity,
      controller: youtubeController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
    );
  }
}
