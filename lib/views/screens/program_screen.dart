import 'package:flutter/material.dart';
import 'package:app_new/models/program_type.dart';
import 'package:app_new/repository/program_type.dart';
import 'package:app_new/models/program_group_video.dart';
import 'package:app_new/repository/program_group_video.dart';
import 'package:app_new/views/widgets/program_list_card.dart';
import 'package:app_new/views/screens/program_detail_screen.dart';
import 'package:app_new/views/screens/food_home_screen.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key, required this.title});
  final String title;

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen>
    with SingleTickerProviderStateMixin {
  late List<ProgramType> programType = [];
  //late List<ProgramGroupVideo> programGroupVideo = [];
  late List<Map<String, dynamic>> programGroupVideoData = [];
  int groupIndexNow = 0;
  int limit = 10;
  late TabController programTabController;
  final ScrollController scrollController = ScrollController();
  int tabActive = 1;
  @override
  void initState() {
    super.initState();

    ProgramTypeRepository().getProgramType().then((e) {
      setState(() {
        programType = e;
        programTabController =
            TabController(length: programType.length, vsync: this);
        for (var i = 0; i < programType.length; i++) {
          final Map<String, dynamic> groupDate = {
            'group_name': programType[i].group_name,
            'page': 0,
            'group_id': programType[i].group_id,
            'isbottom': false,
            'result': []
          };

          programGroupVideoData.add(groupDate);
        }
      });
      programTabController.addListener(() {
        setState(() {
          groupIndexNow = programTabController.index;
        });
        //針對tabController兩次執行的排除
        if (programTabController.indexIsChanging) {
          if (programGroupVideoData[groupIndexNow]['result'].isEmpty) {
            getProgramGroupVideo();
            tabActive = 0;
          }
        } else {
          if (tabActive == 1) {
            getProgramGroupVideo();
          } else {
            tabActive = 1;
          }
        }
      });
      getProgramGroupVideo();
    });
    scrollController.addListener(() {
      //scrollController會被觸發兩次
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !programGroupVideoData[groupIndexNow]['isbottom']) {
        getProgramGroupVideo();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getProgramGroupVideo() async {
    late List<ProgramGroupVideo> moreResult;
    try {
      if (!programGroupVideoData[groupIndexNow]['isbottom']) {
        moreResult = await ProgramGroupVideoRepository().getProgramGroupVideo(
            page: programGroupVideoData[groupIndexNow]['page'] + 1,
            group_id: programGroupVideoData[groupIndexNow]['group_id']);
        setState(() {
          programGroupVideoData[groupIndexNow]['page']++;
          programGroupVideoData[groupIndexNow]['result'].addAll(moreResult);
          moreResult.length < limit
              ? programGroupVideoData[groupIndexNow]['isbottom'] = true
              : programGroupVideoData[groupIndexNow]['isbottom'] = false;
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
            title: Text(widget.title),
            centerTitle: true,
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Color(0xff200e0c),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            bottom: programType.isNotEmpty
                ? TabBar(
                    controller: programTabController,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: programType
                        .map((e) => Tab(text: e.group_name))
                        .toList(),
                  )
                : AppBar(
                    title: const Text(""),
                  )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.large(
                //悬浮按钮
                heroTag: "btn1",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://yt3.ggpht.com/a/AATXAJzuTeSk05um_2Uzg1mTnfLfalH-rAJE6iGMWrik=s200-c-k-c0x00ffffff-no-rj'),
                          fit: BoxFit.cover)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      //fullscreenDialog: true,
                      builder: (context) {
                    return const ProgramDetailScreen(program_item: {
                      "program_id": 28,
                      "pid": 129,
                      "title": "錢線百分百",
                      "program_name": {
                        "pid": 129,
                        "img1":
                            "https://cdn.ustv.com.tw/ModuleImg/ProgramName/129_img1.png",
                        "img2":
                            "https://cdn.ustv.com.tw/ModuleImg/ProgramName/129_img2.png",
                        "first_play_time": "周一至周五 21:00 ~ 23:30",
                        "replay_time": "",
                        "p_intro": ""
                      }
                    });
                  }));
                }),
            const SizedBox(height: 20),
            FloatingActionButton.large(
                //悬浮按钮
                heroTag: "btn2",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://yt3.ggpht.com/a/AATXAJz2GVUSvW8zXj3sPwz2oPTd6ebvbrodSP3wA4vu=s200-c-k-c0x00ffffff-no-rj'),
                          fit: BoxFit.cover)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      //fullscreenDialog: true,
                      builder: (context) {
                    return const FoodHomeScreen(
                      title: '大探索',
                    );
                  }));
                  /*
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const FoodHomeScreen(
                        title: '大探索',
                      ),
                    ),
                  );*/
                  /*Navigator.push(context, MaterialPageRoute(
                      //fullscreenDialog: true,
                      builder: (context) {

                    
                    return const ProgramDetailScreen(
                      program_item: {
                        "program_id": 7,
                        "pid": 2,
                        "title": "非凡大探索",
                        "program_name": {
                          "pid": 2,
                          "img1":
                              "https://cdn.ustv.com.tw/ModuleImg/ProgramName/2_img1.png",
                          "img2":
                              "https://cdn.ustv.com.tw/ModuleImg/ProgramName/2_img2.png",
                          "first_play_time": "每週日20:00~21:00",
                          "replay_time": "隔週日下午12:55~13:55",
                          "p_intro": ""
                        }
                      },
                    );
                  }));*/
                })
          ],
        ),
        body: programType.isNotEmpty
            ? TabBarView(
                controller: programTabController,
                children: programType.map((e) {
                  int dataIndex = programGroupVideoData
                      .indexWhere((f) => f['group_id'] == e.group_id);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 145,
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
                          child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 13.0),
                              itemCount: e.program.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  // 每個子元素都間隔右邊 16 單位
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Column(
                                    // 子元素分成兩部分，圓角灰底的方形將用於顯示圖片 與 新聞來源的文字
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    //fullscreenDialog: true,
                                                    builder: (context) {
                                              return ProgramDetailScreen(
                                                  program_item:
                                                      e.program[index]);
                                            }));
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  image: NetworkImage(e
                                                          .program[index]
                                                      ['program_name']['img2']),
                                                  fit: BoxFit.fitWidth),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100)),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(e.program[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 74, 74, 74))),
                                      )
                                    ],
                                  ),
                                );
                              })),
                      Expanded(
                          child: RefreshIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                        onRefresh: () async {
                          return Future<void>.delayed(
                              const Duration(seconds: 2), () {
                            for (var i = 0;
                                i < programGroupVideoData.length;
                                i++) {
                              programGroupVideoData[i]['page'] = 0;
                              programGroupVideoData[i]['result'] = [];
                              programGroupVideoData[i]['isbottom'] = false;
                            }
                            getProgramGroupVideo();
                          });
                        },
                        //觸發重整通知
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            programGroupVideoData.isNotEmpty
                                ? SliverList.builder(
                                    itemCount: programGroupVideoData[dataIndex]
                                                ['result']
                                            .length +
                                        1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index <
                                          programGroupVideoData[dataIndex]
                                                  ['result']
                                              .length) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: ProgramListCard(
                                              video: programGroupVideoData[
                                                  dataIndex]['result'][index]),
                                        );
                                      } else if (programGroupVideoData[
                                          dataIndex]['isbottom']) {
                                        return const SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: Text('沒有更多資料'),
                                            ));
                                      } else {
                                        return const SizedBox(
                                            height: 100,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      }
                                    })
                                : const SliverToBoxAdapter(
                                    child: SizedBox(
                                        height: 100,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())))
                          ],
                        ),
                      )),
                    ],
                  );
                }).toList(),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
