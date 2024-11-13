import 'package:flutter/material.dart';
import 'package:app_new/models/news_detail.dart';
import 'package:app_new/repository/news_detail.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_new/views/widgets/video_player.dart';

//import 'package:app_new/views/screens/news_list_screen.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsid;
  const NewsDetailScreen({super.key, required this.newsid});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late Future<NewsDetail> result;
  String videoid = '';
  @override
  void initState() {
    super.initState();
    result = NewsDetailRepository().getNewsDetail(newsid: widget.newsid);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildPost(NewsDetail sources) {
    if (sources.video != null) {
      videoid = sources.video!;
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            if (videoid == '') {
              return Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(sources.news_image),
                        fit: BoxFit.fitWidth)
                    //color: Colors.black,
                    ),
              );
            } else {
              return VideoPlayer(ytId: videoid, autoplay: false);
            }
          }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 13.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      sources.newshead,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      sources.subject,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        letterSpacing: 1.5,
                        //backgroundColor: Colors.yellow
                      ),
                    )),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        sources.start_datetime,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 14, 47, 78),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Html(
                  data: sources.web_text,
                  style: {
                    'html': Style(
                      //backgroundColor: Colors.green,
                      fontSize: FontSize(15),
                      lineHeight: const LineHeight(1.3),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                    'img': Style(
                        margin: Margins.only(top: 5.0), display: Display.block),
                  },
                  onLinkTap: (url, _, __) async {
                    final uri = Uri.parse(url!);
                    await launchUrl(uri);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: FutureBuilder(
          future: result,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('發生${snapshot.error}'));
              } else if (snapshot.hasData) {
                return buildPost(snapshot.data as NewsDetail);
              } else {
                return const Center(child: Text('沒有更多資料'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
