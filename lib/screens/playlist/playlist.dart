import 'package:flutter/material.dart';
import 'package:muzoplayer/functions/dbfunctions/playlist_db.dart';
import 'package:muzoplayer/screens/playlist/inside_the_playlist.dart';

class PlayList extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  PlayList({super.key});
  final TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // getAllPlaylist();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.playlist_add),
      ),
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
                'PLAYLISTS',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'KumbhSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 100,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 100, right: 20),
          child: ValueListenableBuilder(
              valueListenable: playlistNotifier,
              builder: (context, playlistValue, child) {
                if (playlistValue.isEmpty) {
                  return const Center(
                    child: Text(
                      'No playlist found',
                    ),
                  );
                }
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InsidePlaylist(
                                    playListName:
                                        playlistNotifier.value[index].name,
                                    playlist: playlistNotifier.value[index]),
                              ));
                            },
                            leading: SizedBox(
                              width: 50,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/playlist.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                playlistNotifier.value[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: 'KumbhSans'),
                              ),
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                value == 1
                                    ? showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'EDIT PLAYLIST NAME'),
                                            content: Form(
                                              key: _key,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Name is required';
                                                  }
                                                  return null;
                                                },
                                                controller: editController,
                                                decoration: InputDecoration(
                                                    hintText: 'Playlist Name'),
                                              ),
                                            ),
                                            actions: [
                                              TextButton.icon(
                                                  onPressed: () {
                                                    if (_key.currentState!
                                                        .validate()) {
                                                      updatePlaylistname(
                                                          index,
                                                          editController.text
                                                              .trim());

                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.check_sharp,
                                                    color: Colors.green,
                                                  ),
                                                  label: Text(
                                                    'SUMBIT',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          );
                                        }))
                                    : playListPopUp(context,
                                        playlistNotifier.value[index].name);
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: Text('Rename'),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Remove Playlist'),
                                    value: 2,
                                  ),
                                ];
                              },
                            ),
                          ),
                        ));
                  },
                  itemCount: playlistNotifier.value.length,
                );
              }),
        )
      ]),
    );
  }

  Future<dynamic> playListPopUp(BuildContext context, String playlistname) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text('PLEASE CONFIRM DELETION'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        deletePlaylist(playlistname);

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
                      onPressed: () async {
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
