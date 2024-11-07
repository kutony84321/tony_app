import 'package:app_new/models/breaking_news.dart';
import 'package:flutter/material.dart';
import 'package:app_new/models/news_list.dart';
import 'package:app_new/repository/news_list.dart';
import 'package:app_new/repository/breaking_news.dart';
import 'package:app_new/views/widgets/news_list_card.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app_new/views/screens/news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key, required this.title});
  final String title;
  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  int newsTabIndex = 0;
  int limit = 10;
  late Future<List<BreakingNews>> breakingNews;
  late List<List<NewsList>> result = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  int tabActive = 1;
  List<Map<String, dynamic>> tabsList = [
    {'name': '即時', 'page': 0, 'id': 0, 'isbottom': false},
    {'name': '政治', 'page': 0, 'id': 107, 'isbottom': false},
    {'name': '產經', 'page': 0, 'id': 103, 'isbottom': false},
    {'name': '金融', 'page': 0, 'id': 144, 'isbottom': false},
    {'name': '科技', 'page': 0, 'id': 146, 'isbottom': false},
    {'name': '國際', 'page': 0, 'id': 104, 'isbottom': false},
    {'name': '理財', 'page': 0, 'id': 147, 'isbottom': false},
    {'name': '房產', 'page': 0, 'id': 112, 'isbottom': false},
    {'name': '生活', 'page': 0, 'id': 105, 'isbottom': false},
    {'name': '娛樂', 'page': 0, 'id': 102, 'isbottom': false},
    {'name': '專欄', 'page': 0, 'id': 149, 'isbottom': false},
    {'name': '影音', 'page': 0, 'id': 110, 'isbottom': false},
    {'name': '其它', 'page': 0, 'id': 109, 'isbottom': false},
  ];
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //scrollController會被觸發兩次
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !tabsList[newsTabIndex]['isbottom']) {
        fetchMore();
      }
    });

    tabController = TabController(length: tabsList.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        newsTabIndex = tabController.index;
      });
      //針對tabController兩次執行的排除
      if (tabController.indexIsChanging) {
        if (result[newsTabIndex].isEmpty) {
          fetchMore();
          tabActive = 0;
        }
      } else {
        if (tabActive == 1) {
          fetchMore();
        } else {
          tabActive = 1;
        }
      }
    });
    fetchMore();
    getBreakingNews();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMore() async {
    if (!tabsList[newsTabIndex]['isbottom']) {
      late List<NewsList> moreResult;
      try {
        moreResult = await NewsListRepository().getNewsList(
            page: tabsList[newsTabIndex]['page'] + 1,
            id: tabsList[newsTabIndex]['id']);
      } catch (e) {
        moreResult = [];
      }
      setState(() {
        tabsList[newsTabIndex]['page']++;
        result[newsTabIndex].addAll(moreResult);
        moreResult.length < limit
            ? tabsList[newsTabIndex]['isbottom'] = true
            : tabsList[newsTabIndex]['isbottom'] = false;
      });
    }
  }

  Future<void> getBreakingNews() async {
    breakingNews = BreakingNewsRepository().getBreakingNews();
  }

  Widget buildBreakingNews(List<BreakingNews> bn) {
    var bnLength = bn.length;
    return Container(
        color: const Color.fromARGB(255, 210, 81, 89),
        height: 50,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 237, 237, 237),
                    ),
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              '快訊',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 210, 81, 89),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.campaign,
                                color: Color.fromARGB(255, 210, 81, 89)),
                          ],
                        ))),
                Expanded(
                    child: Swiper(
                        autoplay: true,
                        itemCount: bnLength,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    //fullscreenDialog: true,
                                    builder: (context) {
                                  return NewsDetailScreen(
                                      newsid: bn[index].url);
                                }));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          bn[index].subject,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ]));
                        })),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            centerTitle: true,
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Color(0xff200e0c),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            bottom: TabBar(
              controller: tabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: const Color(0xffe60412),
              labelStyle: const TextStyle(
                fontSize: 18.0,
                color: Color(0xffe60412),
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
              tabs: tabsList.map((e) => Tab(text: e['name'])).toList(),
            )),
        body: Column(
          children: [
            /**快訊 start */
            FutureBuilder(
                future: breakingNews,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text('快訊發生${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return buildBreakingNews(
                          snapshot.data as List<BreakingNews>);
                    } else {
                      return const SizedBox(height: 0);
                    }
                  } else {
                    return const SizedBox(height: 0);
                  }
                }),
            /**快訊 end */
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: result.map((e) {
                var swiperLength = e.length < 5 ? e.length : 5;
                return RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  onRefresh: () async {
                    return Future<void>.delayed(const Duration(seconds: 2), () {
                      for (var i = 0; i < tabsList.length; i++) {
                        tabsList[i]['page'] = 0;
                        result[i] = [];
                        tabsList[i]['isbottom'] = false;
                      }
                      fetchMore();
                      getBreakingNews();
                    });
                  },
                  //觸發重整通知
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                          child: SizedBox(
                              height: 250,
                              //color: const Color.fromARGB(255, 255, 255, 255),
                              child: e.isNotEmpty
                                  ? Swiper(
                                      autoplay: true,
                                      pagination: const SwiperPagination(),
                                      itemCount: swiperLength,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      //fullscreenDialog: true,
                                                      builder: (context) {
                                                return NewsDetailScreen(
                                                    newsid: e[index].newsid);
                                              }));
                                            },
                                            child: Container(
                                              /*color: Colors.black.withOpacity(0.5),*/
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              BlendMode.darken),
                                                      image: NetworkImage(
                                                          e[index].news_image),
                                                      fit: BoxFit.cover)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 30.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // 新聞分類
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      13,
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffe60412),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14)),
                                                          child: Text(
                                                              e[index].newshead,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white))),
                                                      const SizedBox(height: 8),
                                                      // 標題
                                                      Text(e[index].subject,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22,
                                                              height: 1.2,
                                                              letterSpacing:
                                                                  1.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                    ]),
                                              ),
                                            ));
                                      },
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ))),
                      e.isNotEmpty
                          ? SliverList.builder(
                              itemCount: e.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < e.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: NewsListCard(news: e[index]),
                                  );
                                } else if (tabsList[newsTabIndex]['isbottom']) {
                                  return const SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text('沒有更多資料'),
                                      ));
                                } else {
                                  return const SizedBox(
                                      height: 100,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                              })
                          : const SliverToBoxAdapter(
                              child: SizedBox(
                                  height: 100,
                                  child: Center(
                                      child: CircularProgressIndicator())))
                    ],
                  ),
                );
              }).toList(),
              /*<Widget>[
              FutureBuilder(
                  future: result,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('發生${snapshot.error}'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return buildNewsLit(snapshot.data as List<NewsList>);
                      } else {
                        isbottom = true;
                        return const Center(child: Text('沒有更多資料'));
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  //padding: const EdgeInsets.all(10.0),
                  itemCount: result.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < result.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: NewsListCard(news: result[index]),
                      );
                    } else if (isbottom) {
                      return const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text('沒有更多資料'),
                          ));
                    } else {
                      return const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }),
             
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  result.isNotEmpty
                      ? SliverList.builder(
                          itemCount: result.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < result.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: NewsListCard(news: result[index]),
                              );
                            } else if (isbottom) {
                              return const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text('沒有更多資料'),
                                  ));
                            } else {
                              return const SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                          })
                      : const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()))
                ],
              ),
             
            ],*/
            )),
          ],
        ));
  }
}
