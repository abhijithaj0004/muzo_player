import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/fav_db.dart';
import 'package:muzoplayer/functions/normalfunctions/playSong.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/widgets/mini_player.dart';
import 'package:muzoplayer/widgets/playlist_popup.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongItem extends StatefulWidget {
  const SongItem(
      {super.key,
      required this.song,
      required this.index,
      required this.audioQuery,
      required this.audioList});
  final SongModel song;
  final int index;
  final OnAudioQuery audioQuery;
  final List<Audio> audioList;
  @override
  State<SongItem> createState() => _SongItemState();
}

class _SongItemState extends State<SongItem> {
  bool isExistOrNot = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      isExistOrNot = await checkExist(widget.song.id);
    });
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
            playSong(widget.audioList, widget.index);

            showBottomSheet(
              enableDrag: false,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return player.builderCurrent(
                  builder: (context, playing) {
                    return MiniPlayer(
                      index: widget.index,
                    );
                  },
                );
              },
            );
          },
          leading: QueryArtworkWidget(
            controller: widget.audioQuery,
            id: widget.song.id,
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
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 30,
              child: SizedBox(
                  child: Text(
                widget.song.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'KumbhSans'),
                overflow: TextOverflow.ellipsis,
              )),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              child: Text(
                widget.song.artist ?? "<unknown>",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 1) {
                bool isExist = await checkExist(widget.song.id);
                if (!isExist) {
                  await addToFav(widget.song.id);
                  setState(() {
                    isExistOrNot = true;
                  });
                } else {
                  await removeFromFav(widget.song.id);
                  setState(() {
                    isExistOrNot = false;
                  });
                }
              } else {
                playlistBottomSheet(context, widget.song);
              }
              isExistOrNot
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                          child: Text(
                        'Added to favourite',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: 'KumbhSans'),
                      )),
                      duration: Duration(seconds: 1),
                    ))
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                          child: Text(
                        'Removed from favourite',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: 'KumbhSans'),
                      )),
                      duration: Duration(seconds: 1),
                    ));
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: Row(
                    children: [
                      isExistOrNot
                          ? Icon(
                              Icons.favorite,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      isExistOrNot
                          ? Text('Remove from favorites')
                          : Text('Add to favourites'),
                    ],
                  ),
                  value: 1,
                ),
                PopupMenuItem(
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
                  ),
                  value: 2,
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}

void playlistBottomSheet(BuildContext context, SongModel song) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return PlayListPopUp(
        song: song,
      );
    },
  );
}
