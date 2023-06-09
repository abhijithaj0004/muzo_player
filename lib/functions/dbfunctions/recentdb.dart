import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzoplayer/screens/home/homepage.dart';
import 'package:on_audio_query/on_audio_query.dart';

recentAdd(SongModel song) async {
  
  Box<int> recentDb = await Hive.openBox('recent_Db');
  if (recentList.value.contains(song)) {
    recentList.value.remove(song);
    recentList.value.insert(0, song);
    for (int i = 0; i < recentDb.values.length; i++) {
      int id = recentDb.getAt(i)!;
      if (song.id == id) {
        recentDb.deleteAt(i);
        recentDb.add(song.id);
      }
    }
  } else {
    recentList.value.insert(0, song);
    recentDb.add(song.id);
  }
  if (recentList.value.length > 10) {
    recentList.value = recentList.value.sublist(0, 10);
    recentDb.deleteAt(0);
  }
}
