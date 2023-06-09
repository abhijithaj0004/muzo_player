import 'package:flutter/material.dart';
import 'package:muzoplayer/screens/playlist/playlist.dart';
import 'package:muzoplayer/screens/topbeats/topbeats.dart';
import 'package:muzoplayer/screens/welcomescreens/login.dart';
import 'package:muzoplayer/widgets/home_screen_widgets/music_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> recentList = ValueNotifier([]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = userNameController.text.trim();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * .02,
        MediaQuery.of(context).size.height * .02,
        MediaQuery.of(context).size.width * .02,
        MediaQuery.of(context).size.height * .02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .76,
              MediaQuery.of(context).size.height * .0,
              MediaQuery.of(context).size.width * 0,
              MediaQuery.of(context).size.height * 0,
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'KumbhSans',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      username.isEmpty ? 'Guest' : username,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'KumbhSans',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PlayList()));
                },
                child: ImageCard(
                    text: 'PlayLists', img: 'assets/images/homeimg.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TopBeats()));
                },
                child: ImageCard(
                  img: 'assets/images/homeimg.png',
                  text: 'Top Beats',
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .063,
              MediaQuery.of(context).size.height * .02,
              MediaQuery.of(context).size.width * 0,
              MediaQuery.of(context).size.height * 0,
            ),
            child: const Text(
              'Recently Played',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'KumbhSans',
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: MusicListTile())
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String text;
  final String img;
  const ImageCard({
    super.key,
    required this.text,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .38,
            height: MediaQuery.of(context).size.height * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .14,
            child: Container(
              width: MediaQuery.of(context).size.width * .38,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: Color.fromARGB(101, 204, 193, 193)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'KumbhSans',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
