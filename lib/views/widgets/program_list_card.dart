import 'package:flutter/material.dart';
import 'package:app_new/models/program_group_video.dart';
import 'package:app_new/views/screens/video_play_screen.dart';

class ProgramListCard extends StatelessWidget {
  final ProgramGroupVideo video;
  const ProgramListCard({super.key, required this.video});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return VideoPlayScreen(
                        videoid: video.videoId, autoplay: true);
                  }));
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: Color.fromARGB(255, 218, 218, 218),
                    width: 2,
                  )),
                  /*borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.08),
                                              offset: Offset(0, 3),
                                              blurRadius: 6),
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.06),
                                              offset: Offset(0, 2),
                                              blurRadius: 4)
                                        ]*/
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(video.image),
                              fit: BoxFit.cover,
                            )),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(Icons.play_arrow,
                                  size: 60,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                video.published,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.8)),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Text(video.program_name,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)))
                            ],
                          )),
                      const SizedBox(height: 8),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(video.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  letterSpacing: 1.01))),
                    ]))));
  }
}
