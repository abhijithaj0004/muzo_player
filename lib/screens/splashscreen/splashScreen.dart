import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzoplayer/functions/dbfunctions/playlist_db.dart';
import 'package:muzoplayer/functions/dbfunctions/top_beats_db.dart';
import 'package:muzoplayer/model/favmodel/fav_model.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_class.dart';
import 'package:muzoplayer/model/playlistmodel/playlist_model.dart';
import 'package:muzoplayer/screens/allsongs/allsongs.dart';
import 'package:muzoplayer/screens/favourites/favourites.dart';
import 'package:muzoplayer/screens/home/homepage.dart';
import 'package:muzoplayer/screens/home/main_screen.dart';
import 'package:muzoplayer/screens/welcomescreens/intro_1.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String loginKey = 'log_in';
bool hasPermission = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    // TODO: implement initState
    isFirstUser();
    // checkAndRequestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset('assets/images/muzosplash.png'),
      ),
    );
  }

  Future<void> nextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    await fetchAllSongs();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IntroOne()));
  }

  Future<void> isFirstUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool? userLogInCheck = preferences.getBool(
      loginKey,
    );
    if (userLogInCheck == false || userLogInCheck == null) {
      await nextPage();
    } else {
      await fetchAllSongs();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainPage(),
      ));
    }
  }
}

Future<void> fetchAllSongs() async {
  bool isgranted = await checkAndRequestPermission();
  if (isgranted) {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  } else {
    allsongs = [];
  }

  await fetchRecent();
}

fetchRecent() async {
  await fetchFav();
  await fetchmostplayed();
  await fetchPlaylist();
  final Box<int> recentDb = await Hive.openBox('recent_Db');
  List<SongModel> recenttemp = [];
  for (int element in recentDb.values) {
    for (SongModel song in allsongs) {
      if (element == song.id) {
        recenttemp.add(song);
        break;
      }
    }
  }
  recentList.value = recenttemp.reversed.toList();
}

fetchFav() async {
  List<FavModel> favsongcheck = [];
  final Box<FavModel> favDB = await Hive.openBox('fav_DB');
  favsongcheck.addAll(favDB.values);
  for (var favs in favsongcheck) {
    for (var songs in allsongs) {
      if (favs.id == songs.id) {
        favouritelist.value.insert(0, songs);
        break;
      }
    }
  }
}

fetchPlaylist() async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  for (PlayListModel data in playlistDb.values) {
    EachPlaylist value = EachPlaylist(name: data.playListName);
    if(data.playlistId.isNotEmpty){for (int id in data.playlistId) {
      for (SongModel song in allsongs) {
        if (id == song.id) {
          value.container.add(song);
          break;
        }
      }
    }}
    playlistNotifier.value.add(value);
  }
}

Future<bool> checkAndRequestPermission({bool retry = false}) async {
  hasPermission = await audioQuery.checkAndRequest();
  return hasPermission;
}
