// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/playlist_db.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_class.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListPopUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final SongModel song;
  PlayListPopUp({super.key, required this.song});
  TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 108, 99, 255),
            Color.fromARGB(79, 107, 99, 255),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(400))),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            const Text(
              'ADD TO PLAYLIST',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'KumbhSans'),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.white)),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add New PLaylist'),
                        content: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: playlistController,
                            decoration:
                                const InputDecoration(hintText: 'PlaylistName'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter PlayListName';
                              }
                              value = value.trim();
                              for (EachPlaylist element
                                  in playlistNotifier.value) {
                                if (element.name == value) {
                                  return 'Name already exist';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createPlayList(playlistController.text.trim());
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              width: double.infinity,
              child: const Text(
                'Playlists',
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'KumbhSans'),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: playlistNotifier,
                  builder: (context, playlistBuild, child) {
                    return ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 80,
                          child: ListTile(
                            onTap: () {
                              songAddToPlaylist(
                                  playlistNotifier.value[index].name, song);
                              Navigator.of(context).pop();
                            },
                            title: Text(
                              playlistNotifier.value[index].name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'KumbhSans'),
                            ),
                            leading: SizedBox(
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
                        );
                      },
                      itemCount: playlistBuild.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
