import 'package:flutter/material.dart';
import 'package:app_new/models/food_episode.dart';
import 'package:app_new/repository/food_episode.dart';
import 'package:app_new/views/widgets/food_episode_card.dart';
import 'package:app_new/views/screens/food_search_screen.dart';

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key, required this.title});
  final String title;

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  late Future<List<FoodEpisode>> foodEpisode;

  @override
  void initState() {
    super.initState();

    foodEpisode = FoodEpisodeRepository().getFoodEpisode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildFoodEpisode(List<FoodEpisode> fe) {
    var bnLength = fe.length;
    return Expanded(
      child: ListView.builder(
          itemCount: bnLength,
          itemBuilder: (BuildContext context, int index) {
            return FoodEpisodeCard(episode: fe[index]);
          }),
    );
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
            /*actions: <Widget>[
            IconButton(icon: const Icon(Icons.search), onPressed: () {})
          ],*/
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60), // Set this height
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          //fullscreenDialog: true,
                          builder: (context) {
                        return const FoodSearchScreen(title: "搜尋美食");
                      }));
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
                        ))))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: foodEpisode,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Center(child: Text('大探索發生${snapshot.error}'))
                          ]));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return buildFoodEpisode(
                          snapshot.data as List<FoodEpisode>);
                    } else {
                      return const Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Center(child: Text('沒有更多資料'))]));
                    }
                  } else {
                    return const Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Center(child: CircularProgressIndicator())
                        ]));
                  }
                }),
          ],
        ));
  }
}
