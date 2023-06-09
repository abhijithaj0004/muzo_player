import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/recentdb.dart';
import 'package:muzoplayer/functions/dbfunctions/top_beats_db.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/nowplaying/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

SongModel? currentPLaying;

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key, required this.index});
  final int index;
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 15, right: 15),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NowPlaying(),
            ));
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 125, 114, 249),
                  Color.fromARGB(0, 149, 139, 255),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(15)),
            child: player.builderCurrent(builder: (context, playing) {
              int id = int.parse(playing.audio.audio.metas.id!);
              for (SongModel item in allsongs) {
                if (item.id == id) {
                  currentPLaying = item;
                  recentAdd(currentPLaying!);
                  mostplayedadd(currentPLaying!);
                  break;
                }
              }

              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: QueryArtworkWidget(
                      id: id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: 60,
                      artworkHeight: 80,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(12),
                      nullArtworkWidget: SizedBox(
                        width: 60,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: Text(
                                player.getCurrentAudioTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'KumbhSans'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                player.pause();
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await player.previous();
                              },
                              child: Icon(
                                Icons.skip_previous,
                                size: 40,
                              ),
                            ),
                            player.builderIsPlaying(
                              builder: (context, isPlaying) {
                                return InkWell(
                                  onTap: () async {
                                    await player.playOrPause();
                                  },
                                  child: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              onTap: () async {
                                await player.next();
                              },
                              child: Icon(
                                Icons.skip_next,
                                size: 40,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
