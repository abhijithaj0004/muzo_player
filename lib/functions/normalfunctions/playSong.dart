import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';

playSong(List<Audio> audiolist, int index) async {
  await player.stop();
  await player.open(
      Playlist(
        audios: audiolist,
        startIndex: index,
      ),
      showNotification: true);
}
