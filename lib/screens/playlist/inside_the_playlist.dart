// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/playlist_db.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_class.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> playListNotifierSongModel = ValueNotifier([]);

class InsidePlaylist extends StatelessWidget {
  final EachPlaylist playlist;
  final String playListName;
  const InsidePlaylist(
      {super.key, required this.playlist, required this.playListName});
  @override
  Widget build(BuildContext context) {
    List<Audio> playListSongList = convertToAudio(playlist.container);
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 108, 99, 255),
                Color.fromARGB(79, 107, 99, 255),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(400))),
        ),
        Positioned(
          top: 50,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 100,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  playListName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'KumbhSans',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 100, right: 20),
          child: ValueListenableBuilder(
              valueListenable: playlistNotifier,
              builder: (context, playlistvalue, _) {
                return playlist.container.isEmpty
                    ? songIsEmpty()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 90,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 203, 203, 203),
                                    Color.fromARGB(0, 207, 207, 207),
                                  ]),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    playSong(playListSongList, index);
                                    showBottomSheet(
                                      enableDrag: false,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return player.builderCurrent(
                                          builder: (context, playing) {
                                            return MiniPlayer(
                                              index: index,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  leading: QueryArtworkWidget(
                                    id: playlist.container[index].id,
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
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      playlist.container[index].displayName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'KumbhSans'),
                                    ),
                                  ),
                                  subtitle: const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text('<Unknown>'),
                                  ),
                                  trailing: PopupMenuButton(
                                    icon: const Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      playListPopUp(context, index);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry>[
                                        const PopupMenuItem(
                                          value: 0,
                                          child: Text('Remove'),
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              ));
                        },
                        itemCount: playlist.container.length,
                      );
              }),
        )
      ]),
    );
  }

  songIsEmpty() {
    return Center(
      child: Text('No Songs'),
    );
  }

  playListPopUp(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('PLEASE CONFIRM DELETION'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        deleteFromPlaylist(
                            playlist.name, playlist.container[index]);

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'YES',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'NO',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))
                ],
              ),
            ],
          );
        }));
  }
}
