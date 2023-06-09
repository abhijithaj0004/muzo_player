import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/favourites/favourites.dart';
import 'package:muzoplayer/screens/home/homepage.dart';
import 'package:muzoplayer/widgets/app_bar.dart';
import 'package:muzoplayer/widgets/drawewidget/list_of_drawer.dart';
import 'package:muzoplayer/widgets/ellipse.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selecteditems = 0;

  List<Widget> screens = [
    AllSongs(),
    HomePage(),
    Favourites(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: Color.fromARGB(255, 173, 168, 246),
      appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.05),
          child: CustomAppBar(
              iconnButton: selecteditems == 2 ? false : true,
              title: selecteditems == 1
                  ? 'HOME'
                  : selecteditems == 0
                      ? 'ALL SONGS'
                      : 'FAVOURITES')),
      body: screens[selecteditems],
      bottomNavigationBar: CurvedNavigationBar(
        index: selecteditems,
        backgroundColor: Color.fromARGB(255, 173, 168, 246),
        color: Color.fromARGB(255, 108, 99, 255),
        items: const [
          Icon(
            Icons.music_note_outlined,
            color: Colors.white,
            size: 40,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
            size: 40,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: 40,
          )
        ],
        onTap: (int i) {
          setState(() {
            selecteditems = i;
          });
        },
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 211, 208, 255),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 114, 107, 249),
                Color.fromARGB(0, 114, 107, 249)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                child: Text(
                  'M U Z O',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'KumbhSans',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DrawerList()
            )),
            Expanded(
                child: Stack(
              children: [
                Positioned(
                    bottom: -100,
                    child: Ellipse(color: Color.fromARGB(54, 89, 52, 255))),
                Positioned(
                    left: -100,
                    bottom: -30,
                    child: Ellipse(color: Color.fromRGBO(158, 158, 158, 0.249)))
              ],
            ))
          ],
        ));
  }

  
}
ListTile settings(
      {required String title, required IconData icon, Function()? toNextPage}) {
    return ListTile(
      onTap: toNextPage,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'KumbhSans',
          // fontWeight: FontWeight.bold,
        ),
      ),
      leading: CircleAvatar(
        radius: 20,
        child: Icon(
          icon,
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }