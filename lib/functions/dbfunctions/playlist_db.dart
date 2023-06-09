import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_class.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<EachPlaylist>> playlistNotifier = ValueNotifier([]);
createPlayList(playListName) async {
  playlistNotifier.value.add(EachPlaylist(name: playListName));
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  await playlistDb.put(playListName, PlayListModel(playListName: playListName));
  playlistNotifier.notifyListeners();
}

deletePlaylist(String PlaylistName) async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  playlistDb.delete(PlaylistName);
  for (EachPlaylist data in playlistNotifier.value) {
    if (data.name == PlaylistName) {
      playlistNotifier.value.remove(data);
      break;
    }
  }
  playlistNotifier.notifyListeners();
}

updatePlaylistname(int index, String newName) async {
  String playListName = playlistNotifier.value[index].name;
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  for (PlayListModel element in playlistDb.values) {
    if (element.playListName == playListName) {
      var key = element.key;
      element.playListName = newName;
      playlistDb.put(key, element);
    }
  }
  playlistNotifier.value[index].name = newName;
  playlistNotifier.notifyListeners();
}

songAddToPlaylist(String playlistName, SongModel song) async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  PlayListModel data = playlistDb.get(playlistName)!;
  data.playlistId.add(song.id);
  playlistDb.put(playlistName, data);
  for (EachPlaylist value in playlistNotifier.value) {
    if (value.name == playlistName && !value.container.contains(song)) {
      value.container.add(song);
      break;
    }
  }
  playlistNotifier.notifyListeners();
}

deleteFromPlaylist(String playlistName, SongModel song) async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  PlayListModel data = playlistDb.get(playlistName)!;
  data.playlistId.remove(song.id);
playlistDb.put(playlistName, data);
  for (EachPlaylist value in playlistNotifier.value) {
    if (value.name == playlistName) {
      value.container.remove(song);
    }
  }
  playlistNotifier.notifyListeners();
}
