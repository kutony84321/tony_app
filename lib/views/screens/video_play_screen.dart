import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:app_new/views/widgets/video_player.dart';

//import 'package:app_new/views/screens/news_list_screen.dart';

class VideoPlayScreen extends StatelessWidget {
  const VideoPlayScreen(
      {super.key, required this.videoid, required this.autoplay});
  final String videoid;
  final bool autoplay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.black,
          /*leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xff200e0c)), //自定义图标
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    maintainState: false,
                    builder: (context) {
                      return const NewsListScreen(title: '新聞');
                    }),
              );
            },
          );
        }),*/
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: VideoPlayer(ytId: videoid, autoplay: autoplay),
              ),
            ],
          ),
        ));
  }
}
