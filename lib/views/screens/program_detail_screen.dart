// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app_new/models/program_detail_video.dart';
import 'package:app_new/repository/program_detail_video.dart';
import 'package:app_new/views/widgets/program_list_card2.dart';

//import 'package:app_new/views/screens/news_list_screen.dart';

class ProgramDetailScreen extends StatefulWidget {
  final Map<String, dynamic> program_item;
  const ProgramDetailScreen({super.key, required this.program_item});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  final ScrollController scrollController = ScrollController();
  int limit = 10;
  late Map<String, dynamic> programDetailVideoData = {
    'page': 0,
    'isbottom': false,
    'result': []
  };
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //scrollController會被觸發兩次
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !programDetailVideoData['isbottom']) {
        getProgramDetailVideo();
      }
    });
    getProgramDetailVideo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getProgramDetailVideo() async {
    late List<ProgramDetailVideo> moreResult;
    try {
      if (!programDetailVideoData['isbottom']) {
        moreResult = await ProgramDetailVideoRepository().getProgramDetailVideo(
            page: programDetailVideoData['page'] + 1,
            program_id: widget.program_item['program_id']);
        setState(() {
          programDetailVideoData['page']++;
          programDetailVideoData['result'].addAll(moreResult);
          moreResult.length < limit
              ? programDetailVideoData['isbottom'] = true
              : programDetailVideoData['isbottom'] = false;
        });
      }
    } catch (e) {
      moreResult = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.program_item['title']),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Color(0xff200e0c),
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,

          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 2), () {
              programDetailVideoData['page'] = 0;
              programDetailVideoData['result'] = [];
              getProgramDetailVideo();
            });
          },
          //觸發重整通知
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.03),
                              offset: Offset(0, 2),
                              blurRadius: 4)
                        ],
                        /*border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 0.2,
                            ),
                          )*/
                      ),
                      //height: 250,
                      //color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget
                                        .program_item['program_name']['img1']),
                                    fit: BoxFit.fitWidth)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(widget
                                        .program_item['program_name']['img2']),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(widget.program_item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  height: 1.2,
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                              width: 220,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                    widget.program_item['program_name']
                                            ['first_play_time'] ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 57, 57, 57),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      height: 1.2,
                                    )),
                              )),
                        ],
                      ))),
              programDetailVideoData['result'].isNotEmpty
                  ? SliverList.builder(
                      itemCount: programDetailVideoData['result'].length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < programDetailVideoData['result'].length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: ProgramListCard2(
                                video: programDetailVideoData['result'][index]),
                          );
                        } else if (programDetailVideoData['isbottom']) {
                          return const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text('沒有更多資料'),
                              ));
                        } else {
                          return const SizedBox(
                              height: 100,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      })
                  : const SliverToBoxAdapter(
                      child: SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator())))
            ],
          ),
        ));
  }
}
