import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:muzoplayer/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzoplayer/screens/splashscreen/splashScreen.dart';
import 'package:muzoplayer/widgets/songlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer player = AssetsAudioPlayer();

List<SongModel> allsongs = [];
// bool currentlyPlaying = false;

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    List<Audio> listOfAudios = convertToAudio(allsongs);
    return allsongs.isEmpty
        ? const Center(child: Text("No Songs"))
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                await fetchAllSongs();
              },
              child: Scrollbar(
                interactive: true,
                thumbVisibility: true,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    SongModel song = allsongs[index];
                    return SongItem(
                        audioList: listOfAudios,
                        song: song,
                        index: index,
                        audioQuery: audioQuery);
                  },
                  itemCount: allsongs.length,
                ),
              ),
            ),
          );
  }
}
