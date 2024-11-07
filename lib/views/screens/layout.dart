import 'package:flutter/material.dart';
import 'package:app_new/views/screens/news_list_screen.dart';
import 'package:app_new/views/screens/news_topic_screen.dart';
import 'package:app_new/views/screens/program_screen.dart';
import 'package:app_new/views/screens/program_menu_screen.dart';
import 'package:app_new/views/screens/live_video_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  final List<Widget> getScreen = [
    const NewsListScreen(
      title: '新聞',
    ),
    const NewsTopicScreen(
      title: '專題',
    ),
    const ProgramScreen(
      title: '影音',
    ),
    const ProgramMenuScreen(
      title: '節目表',
    ),
    const LiveVideoScreen(
      title: '直播',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 0, 0),
            ),
          ],
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 223, 143, 143))),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "新聞"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "專題"),
            BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video), label: "影音"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "節目表"),
            BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "直播"),
          ],
          currentIndex: _selectedIndex,
          fixedColor: const Color(0xffe60412),
          onTap: _onItemTapped,
          selectedFontSize: 15.0,
          unselectedFontSize: 15.0,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
