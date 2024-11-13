import 'package:flutter/material.dart';
import 'package:app_new/views/widgets/food_search_inner.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key, required this.title});
  final String title;

  @override
  State<FoodSearchScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodSearchScreen> {
  //late Future<List<FoodEpisode>> foodEpisode;
  bool cityShow = true;
  bool subareaShow = false;
  bool typeShow = true;
  bool subtypeShow = false;

  String cityName = "";
  String subareaName = "";
  String typeName = "";
  String subtypeName = "";

  @override
  void initState() {
    super.initState();

    //foodEpisode = FoodEpisodeRepository().getFoodEpisode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*Widget buildFoodEpisode(List<FoodEpisode> fe) {
    var bnLength = fe.length;
    return Expanded(
      child: ListView.builder(
          itemCount: bnLength,
          itemBuilder: (BuildContext context, int index) {
            return FoodEpisodeCard(episode: fe[index]);
          }),
    );
  }*/

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

          /*
            bottom: 
            PreferredSize(
                preferredSize: const Size.fromHeight(60), // Set this height
                child: GestureDetector(
                    onTap: () {
                      /*
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    //fullscreenDialog: true,
                                                    builder: (context) {
                                              return ProgramDetailScreen(
                                                  program_item:
                                                      e.program[index]);
                                            }));*/
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  offset: Offset(0, 2),
                                  blurRadius: 4)
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.search,
                                    color: Color.fromARGB(255, 102, 102, 102),
                                  )),
                              SizedBox(width: 10),
                              Text('搜尋美食',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 102, 102, 102)))
                            ],
                          ),
                        ))))*/
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  autofocus: true,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 102, 102, 102)),
                  decoration: InputDecoration(
                    hintText: "輸入想吃的東西",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text('地區',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  child: Text('選擇想搜尋的縣市',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                ),
                Wrap(
                  spacing: 10.0,
                  children: [
                    cityName != ""
                        ? ActionChip(
                            label: Text(
                              cityName,
                              style: const TextStyle(fontSize: 14),
                            ),
                            avatar: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                cityName = '';
                                subareaName = '';
                                cityShow = true;
                                subareaShow = false;
                              });
                            },
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                    subareaName != ""
                        ? ActionChip(
                            label: Text(
                              subareaName,
                              style: const TextStyle(fontSize: 14),
                            ),
                            avatar: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                subareaName = '';
                                cityShow = false;
                                subareaShow = true;
                              });
                            },
                          )
                        : const SizedBox(
                            width: 0,
                          )
                  ],
                ),
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: cityShow,
                    child: Wrap(
                      //alignment: WrapAlignment.center,
                      spacing: 10.0,
                      children: [
                        ActionChip(
                          label: const Text(
                            '台北市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              cityName = '台北市';
                              cityShow = false;
                              subareaShow = true;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '新北市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              cityName = '新北市';
                              cityShow = false;
                              subareaShow = true;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '桃園市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              cityName = '桃園市';
                              cityShow = false;
                              subareaShow = true;
                            });
                          },
                        ),
                      ],
                    )),
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: subareaShow,
                    child: Wrap(
                      //alignment: WrapAlignment.center,
                      spacing: 10.0,
                      children: [
                        ActionChip(
                          label: const Text(
                            '萬華區',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subareaName = '萬華區';
                              subareaShow = false;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '松山區',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subareaName = '松山區';
                              subareaShow = false;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '大同區',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subareaName = '大同區';
                              subareaShow = false;
                            });
                          },
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text('分類',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  child: Text('選擇想尋找的類別',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                ),
                Wrap(
                  spacing: 10.0,
                  children: [
                    typeName != ""
                        ? ActionChip(
                            label: Text(
                              typeName,
                              style: const TextStyle(fontSize: 14),
                            ),
                            avatar: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                typeName = '';
                                subtypeName = '';
                                typeShow = true;
                                subtypeShow = false;
                              });
                            },
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                    subtypeName != ""
                        ? ActionChip(
                            label: Text(
                              subtypeName,
                              style: const TextStyle(fontSize: 14),
                            ),
                            avatar: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                subtypeName = '';
                                typeShow = false;
                                subtypeShow = true;
                              });
                            },
                          )
                        : const SizedBox(
                            width: 0,
                          )
                  ],
                ),
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: typeShow,
                    child: Wrap(
                      //alignment: WrapAlignment.center,
                      spacing: 10.0,
                      children: [
                        ActionChip(
                          label: const Text(
                            '火鍋',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              typeName = '火鍋';
                              typeShow = false;
                              subtypeShow = true;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '異國料理',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              typeName = '異國料理';
                              typeShow = false;
                              subtypeShow = true;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '神奇食物',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              typeName = '神奇食物';
                              typeShow = false;
                              subtypeShow = true;
                            });
                          },
                        ),
                      ],
                    )),
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: subtypeShow,
                    child: Wrap(
                      //alignment: WrapAlignment.center,
                      spacing: 10.0,
                      children: [
                        ActionChip(
                          label: const Text(
                            '寧夏夜市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subtypeName = '寧夏夜市';
                              subtypeShow = false;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '士林夜市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subtypeName = '士林夜市';
                              subtypeShow = false;
                            });
                          },
                        ),
                        ActionChip(
                          label: const Text(
                            '饒河夜市',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              subtypeName = '饒河夜市';
                              subtypeShow = false;
                            });
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                    ),
                    label: const Text(
                      "立即搜尋",
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        /*
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),*/
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        iconColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 210, 81, 89)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      //下縮式彈窗
                      await showModalBottomSheet<int>(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return const FoodSearchInner();
                        },
                      );
                    },
                  ),
                )
              ],
            )));
  }
}
