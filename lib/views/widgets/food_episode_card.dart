import 'package:flutter/material.dart';
import 'package:app_new/models/food_episode.dart';
import 'package:app_new/views/widgets/food_episode_inner.dart';
import 'package:flutter_html/flutter_html.dart';

class FoodEpisodeCard extends StatelessWidget {
  final FoodEpisode episode;
  const FoodEpisodeCard({super.key, required this.episode});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 3),
                      blurRadius: 6),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 4)
                ]),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: () async {
                    //下縮式彈窗
                    await showModalBottomSheet<int>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FoodEpisodeInner(
                            episode: episode, shop_index: 999);
                      },
                    );
                  },
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          color: const Color.fromARGB(255, 230, 230, 230),
                          image: DecorationImage(
                            image: episode.video_id != ""
                                ? NetworkImage(
                                    "https://i.ytimg.com/vi/${episode.video_id}/mqdefault.jpg")
                                : const NetworkImage(
                                    "https://storage.googleapis.com/ustvweb-cdn/ModuleImg/ProgramName/2_img2.png?20241112155822"),
                            fit: BoxFit.cover,
                          )),
                      child: episode.video_id != ""
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Text(
                                                "第${episode.episode_number}集 ${episode.date}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white)))
                                      ],
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Center(
                                  child: Icon(Icons.play_arrow,
                                      size: 60,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ],
                            )
                          : const SizedBox(height: 0))),
              const SizedBox(height: 8),
              GestureDetector(
                  onTap: () async {
                    //下縮式彈窗
                    await showModalBottomSheet<int>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FoodEpisodeInner(
                            episode: episode, shop_index: 999);
                      },
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Text(episode.subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                              letterSpacing: 1.01)))),
              GestureDetector(
                  onTap: () async {
                    //下縮式彈窗
                    await showModalBottomSheet<int>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FoodEpisodeInner(
                            episode: episode, shop_index: 999);
                      },
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 5),
                      child: Html(
                        data: episode.intro,
                        style: {
                          'html': Style(
                            //backgroundColor: Colors.green,
                            fontSize: FontSize(14),
                            lineHeight: const LineHeight(1.3),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.0,
                          ),
                        },
                      ))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 120,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0),
                      itemCount: (episode.shop).length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          // 每個子元素都間隔右邊 16 單位
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: GestureDetector(
                              onTap: () async {
                                //下縮式彈窗
                                await showModalBottomSheet<int>(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FoodEpisodeInner(
                                        episode: episode, shop_index: index);
                                  },
                                );
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 230, 230),
                                  image: DecorationImage(
                                      image: episode.shop[index]['video'] !=
                                                  "" &&
                                              episode.shop[index]['video'] !=
                                                  null
                                          ? NetworkImage(
                                              "https://i.ytimg.com/vi/${episode.shop[index]['video']}/mqdefault.jpg")
                                          : const NetworkImage(
                                              "https://yt3.googleusercontent.com/ytc/AIdro_nf5tmNp0Xrlcw8-lwuW8CUfE2JpmprZc-8VLuVqUXhkkU=s160-c-k-c0x00ffffff-no-rj"),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.65),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(20))),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0, vertical: 5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(episode.shop[index]['name'],
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }))
            ])));
  }
}
