import 'package:flutter/material.dart';
import 'package:app_new/views/screens/video_play_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodShopCard extends StatelessWidget {
  final Map<String, dynamic> shop;
  const FoodShopCard({super.key, required this.shop});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
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
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        shop['time'] != null && shop['time'] != ""
                            ? Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    height: 1.2,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    const WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          Icons.watch_later,
                                          color: Colors.green,
                                          size: 18,
                                        )),
                                    TextSpan(text: shop['time']),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        shop['rest'] != null && shop['rest'] != ""
                            ? Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    height: 1.2,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    const WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                          size: 18,
                                        )),
                                    TextSpan(text: shop['rest']),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          shop['city'] + shop['sub_area'] + shop['address'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.location_pin,
                      size: 18,
                    ),
                    label: const Text(
                      "查看地圖",
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        /*
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),*/
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                        iconColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 210, 81, 89)),
                    onPressed: () {
                      String googleUrl =
                          'https://www.google.com/maps?q=${shop['city'] + shop['sub_area'] + shop['address']}';
                      launchUrl(Uri.parse(googleUrl));
                    },
                  ),
                  /*
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 13.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 165, 165, 165),
                        ),
                        child: Text(
                          shop['boss'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )*/
                ],
              ),
            )),
            const SizedBox(
              width: 15.0,
            ),
            shop['video'] != null && shop['video'] != ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return VideoPlayScreen(
                                    videoid: shop['video'], autoplay: true);
                              }));
                    },
                    child: Container(
                      width: 130,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.ytimg.com/vi/${shop['video']}/mqdefault.jpg"),
                              fit: BoxFit.cover)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(Icons.play_arrow,
                                size: 60,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ],
                      ),
                    ))
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
