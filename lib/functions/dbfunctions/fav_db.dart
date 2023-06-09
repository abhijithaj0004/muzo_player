import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzoplayer/model/favmodel/fav_model.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/favourites/favourites.dart';

addToFav(int id) async {
  final favDB = await Hive.openBox<FavModel>('fav_DB');
  await favDB.add(FavModel(id: id));
  for (var elements in allsongs) {
    if (elements.id == id) {
      favouritelist.value.insert(0, elements);
    }
  }
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavModel>('fav_DB');

  for (FavModel elements in favDB.values) {
    if (elements.id == id) {
      var key = elements.key;
      favDB.delete(key);
    }
  }
  for (var element in allsongs) {
    if (element.id == id) {
      favouritelist.value.remove(element);
    }
  }
  favouritelist.notifyListeners();
}

Future<bool> checkExist(int id) async {
  final favDB = await Hive.openBox<FavModel>('fav_DB');
  bool isExist = false;
  for (FavModel elements in favDB.values) {
    if (elements.id == id) {
      isExist = true;
    }
  }
  return isExist;
}
