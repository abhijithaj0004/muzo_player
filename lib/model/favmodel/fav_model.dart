import 'package:hive_flutter/hive_flutter.dart';
part 'fav_model.g.dart';

@HiveType(typeId: 1)
class FavModel extends HiveObject {
  @HiveField(0)
  final int id;

  FavModel({required this.id});
}
