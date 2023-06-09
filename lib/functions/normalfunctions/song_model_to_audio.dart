import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<Audio> convertToAudio(List<SongModel> songModelList) {
  List<Audio> convertedList = [];
  for (int i = 0; i < songModelList.length; i++) {
    SongModel songModel = songModelList[i];
    Audio song = Audio.file(songModel.uri!,
        metas: Metas(
            id: songModel.id.toString(),
            title: songModel.displayNameWOExt,
            artist: songModel.artist));
    convertedList.add(song);

  }
  return convertedList;
}
