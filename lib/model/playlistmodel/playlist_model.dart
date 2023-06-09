import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String playListName;
  @HiveField(1)
  List<int> playlistId = [];

  PlayListModel({required this.playListName});
}
