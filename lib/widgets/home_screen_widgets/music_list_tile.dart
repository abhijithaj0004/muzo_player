// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/home/homepage.dart';
import 'package:muzoplayer/widgets/mini_player.dart';
import 'package:muzoplayer/widgets/songlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicListTile extends StatelessWidget {
  List<Audio> listOfAudios = convertToAudio(recentList.value);
  MusicListTile({
    super.key,
  });
  songListEmpty() {
    return const Center(
      child: Text('play Songs'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ValueListenableBuilder(
          valueListenable: recentList,
          builder: (context, recentvalue, child) {
            return recentList.value.isEmpty
                ? songListEmpty()
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
                                playSong(listOfAudios, index);
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
                                id: recentList.value[index].id,
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
                                  recentList.value[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'KumbhSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    recentList.value[index].artist.toString()),
                              ),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  playlistBottomSheet(
                                      context, recentList.value[index]);
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
                    itemCount: recentList.value.length,
                  );
          }),
    );
  }
}
