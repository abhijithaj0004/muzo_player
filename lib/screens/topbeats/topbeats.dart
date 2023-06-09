// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> mostplayed = ValueNotifier([]);

class TopBeats extends StatelessWidget {
  List<Audio> mostPlayedSongs = convertToAudio(mostplayed.value);
  TopBeats({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'TOPBEATS',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'KumbhSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 100, right: 20),
          child: mostplayed.value.isEmpty
              ? songListEmpty()
              : ValueListenableBuilder(
                  valueListenable: mostplayed,
                  builder: (context, value, _) {
                    return ListView.builder(
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
                                  playSong(mostPlayedSongs, index);
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
                                  id: value[index].id,
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
                                    value[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20, fontFamily: 'KumbhSans'),
                                  ),
                                ),
                              ),
                            ));
                      },
                      itemCount: value.length,
                    );
                  }),
        ),
      ]),
    );
  }

  songListEmpty() {
    return const Center(child: Text('No TopBeats'));
  }
}
