import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/topbeats/topbeats.dart';
import 'package:on_audio_query/on_audio_query.dart';

fetchmostplayed() async {
  final Box<int> topBeats_db = await Hive.openBox('top_beats_db');
  if (topBeats_db.isEmpty) {
    for (SongModel elements in allsongs) {
      topBeats_db.put(elements.id, 0);
    }
  } else {
    for (int id in topBeats_db.keys) {
      int count = topBeats_db.get(id) ?? 0;
      if (count > 4) {
        for (SongModel element in allsongs) {
          if (element.id == id) {
            mostplayed.value.add(element);
            break;
          }
        }
      }
    }
    if (mostplayed.value.length > 10) {
      mostplayed.value = mostplayed.value.sublist(0, 10);
    }
  }
}

mostplayedadd(SongModel song) async {
  final Box<int> topBeats_db = await Hive.openBox('top_beats_db');
  int count = (topBeats_db.get(song.id) ?? 0) + 1;
  topBeats_db.put(song.id, count);
  if (count > 4 && !mostplayed.value.contains(song)) {
    print('song added-------------------------------------------------');
    mostplayed.value.add(song);
  }
  if (mostplayed.value.length > 10) {
    mostplayed.value = mostplayed.value.sublist(0, 10);
  }
  //  topBeats_db.clear();
}
