import 'package:hive_flutter/hive_flutter.dart';
    part 'topbeats_model.g.dart';
@HiveType(typeId: 3)
class TopBeatsModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  int count;

  TopBeatsModel({required this.id,required this.count});
}
