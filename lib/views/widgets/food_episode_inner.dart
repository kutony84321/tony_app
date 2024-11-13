// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app_new/models/food_episode.dart';
import 'package:app_new/views/widgets/video_player.dart';
import 'package:app_new/views/widgets/food_shop_card.dart';

class FoodEpisodeInner extends StatefulWidget {
  final FoodEpisode episode;
  final int shop_index;
  const FoodEpisodeInner(
      {super.key, required this.episode, required this.shop_index});

  @override
  State<FoodEpisodeInner> createState() => _FoodEpisodeInnerState();
}

class _FoodEpisodeInnerState extends State<FoodEpisodeInner> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.shop_index < 999) {
      gotoShop();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void gotoShop() {
    Future.delayed(Duration.zero, () {
      scrollController.animateTo(230 + 85 + widget.shop_index * 154,
          duration: const Duration(seconds: 2), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(children: [
        Expanded(
          child: Stack(
            textDirection: TextDirection.rtl,
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                      child: SizedBox(
                    height: 230,
                    //color: const Color.fromARGB(255, 255, 255, 255),
                    child: Builder(builder: (context) {
                      if (widget.episode.video_id == '') {
                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://storage.googleapis.com/ustvweb-cdn/ModuleImg/ProgramName/2_img2.png?20241112155822'),
                                  fit: BoxFit.fitWidth)
                              //color: Colors.black,
                              ),
                        );
                      } else {
                        return VideoPlayer(
                            ytId: widget.episode.video_id, autoplay: false);
                      }
                    }),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                    //height: 35,
                    //color: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text(widget.episode.subject,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                              "第${widget.episode.episode_number}集 ${widget.episode.date}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                  )),
                  widget.episode.shop.isNotEmpty
                      ? SliverList.builder(
                          itemCount: widget.episode.shop.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < widget.episode.shop.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: FoodShopCard(
                                    shop: widget.episode.shop[index]),
                              );
                            } else {
                              return const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text('沒有更多資料'),
                                  ));
                            }
                          })
                      : const SliverToBoxAdapter(
                          child: SizedBox(
                          height: 0,
                        ))
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColor),
                        iconColor: const WidgetStatePropertyAll(Colors.white)),
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )
            ],
          ),
        ),

        //const Divider(height: 1.0),
      ]),
    );
  }
}
