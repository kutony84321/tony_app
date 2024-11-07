import 'package:flutter/material.dart';
import 'package:app_new/models/news_list.dart';
import 'package:app_new/views/screens/news_detail_screen.dart';

class NewsListCard extends StatelessWidget {
  final NewsList news;
  const NewsListCard({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              //fullscreenDialog: true,
              builder: (context) {
            return NewsDetailScreen(newsid: news.newsid);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    offset: Offset(0, 3),
                    blurRadius: 6),
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    offset: Offset(0, 2),
                    blurRadius: 4)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.start_datetime,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              news.subject,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ]),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 13.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 165, 165, 165),
                        ),
                        child: Text(
                          news.newshead,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      image: DecorationImage(
                          image: NetworkImage(news.news_image),
                          fit: BoxFit.cover)),
                )
              ],
            ),
          ),
        ));
  }
}
