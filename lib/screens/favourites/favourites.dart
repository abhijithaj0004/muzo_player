// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/fav_db.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/widgets/RemovePopUp.dart';
import 'package:muzoplayer/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> favouritelist = ValueNotifier([]);
OnAudioQuery audioQuery = OnAudioQuery();

class Favourites extends StatelessWidget {
  List<Audio> listOfAudiosFav = [];
  Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    listOfAudiosFav = convertToAudio(favouritelist.value);
    return ValueListenableBuilder(
      valueListenable: favouritelist,
      builder: (context, value, child) {
        return (favouritelist.value.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, indx) {
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
                              playSong(listOfAudiosFav, indx);
                              showBottomSheet(
                                enableDrag: false,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return player.builderCurrent(
                                    builder: (context, playing) {
                                      return MiniPlayer(
                                        index: indx,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            leading: QueryArtworkWidget(
                              controller: audioQuery,
                              id: favouritelist.value[indx].id,
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
                                favouritelist.value[indx].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: 'KumbhSans'),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                favouritelist.value[indx].artist.toString(),
                              ),
                            ),
                            trailing: RemovePopUp(onpressedClicked: () {
                              removeFromFav(favouritelist.value[indx].id);
                              Navigator.of(context).pop();
                            })),
                      ),
                    );
                  },
                  itemCount: favouritelist.value.length,
                ),
              )
            : const Center(
                child: Text('Please add songs to favourites'),
              );
      },
    );
  }
}
