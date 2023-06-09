import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/nowplaying/now_playing.dart';
import 'package:muzoplayer/widgets/songlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  List<Audio> listOfAudioSearch = [];

  @override
  Widget build(BuildContext context) {
    final searchcontroller = TextEditingController();
    listOfAudioSearch = convertToAudio(allsongs);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 208, 255),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 108, 99, 255),
                  Color.fromARGB(79, 107, 99, 255),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(200))),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 60, left: 30),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100, right: 50, left: 50),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 164, 160, 236),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Search Songs',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'KumbhSans',
                              fontSize: 20,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            )),
                        onChanged: (value) => search(value.trim()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ValueListenableBuilder(
                valueListenable: data,
                builder: (context, value, child) {
                  return searchcontroller.text.isEmpty ||
                          searchcontroller.text.trim().isEmpty
                      ? fullsonglist()
                      : data.value.isEmpty
                          ? searchEmpty()
                          : searchFound();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  searchEmpty() {
    return Center(
      child: Text('Song not found'),
    );
  }

  searchFound() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 90,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 203, 203, 203),
                  Color.fromARGB(0, 207, 207, 207),
                ]),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: ListTile(
                onTap: () {
                  int songIndex = 0;
                  for (int i = 0; i < allsongs.length; i++) {
                    if (data.value[index] == allsongs[i]) {
                      songIndex = i;
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }
                  playSong(listOfAudioSearch, songIndex);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NowPlaying(),
                  ));
                },
                leading: QueryArtworkWidget(
                  id: data.value[index].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 50,
                  artworkHeight: 80,
                  artworkFit: BoxFit.cover,
                  artworkBorder: BorderRadius.circular(12),
                  nullArtworkWidget: SizedBox(
                    width: 50,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/allsongs.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    data.value[index].displayNameWOExt,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontFamily: 'KumbhSans'),
                  ),
                ),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    playlistBottomSheet(context, data.value[index]);
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.playlist_add,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add to playlist'),
                            ],
                          ))
                    ];
                  },
                ),
              ),
            ));
      },
      itemCount: data.value.length,
    );
  }

  fullsonglist() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var id = allsongs[index].id;
        return Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 90,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 203, 203, 203),
                  Color.fromARGB(0, 207, 207, 207),
                ]),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: ListTile(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  playSong(listOfAudioSearch, index);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NowPlaying(),
                  ));
                },
                leading: QueryArtworkWidget(
                  id: id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 50,
                  artworkHeight: 80,
                  artworkFit: BoxFit.cover,
                  artworkBorder: BorderRadius.circular(12),
                  nullArtworkWidget: SizedBox(
                    width: 50,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/allsongs.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    allsongs[index].displayNameWOExt,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontFamily: 'KumbhSans'),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(allsongs[index].artist.toString()),
                ),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    playlistBottomSheet(context, allsongs[index]);
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.playlist_add,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add to playlist'),
                            ],
                          ))
                    ];
                  },
                ),
              ),
            ));
      },
      itemCount: allsongs.length,
    );
  }

  ValueNotifier<List<SongModel>> data = ValueNotifier([]);
  search(String text) {
    data.value = allsongs
        .where((song) => song.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
    data.notifyListeners();
  }
}
