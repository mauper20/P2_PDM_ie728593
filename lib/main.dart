import 'package:flutter/material.dart';
import 'package:p1_app/pages/favorite_songs.dart';
import 'package:p1_app/pages/infomusic_page.dart';
import 'package:p1_app/pages/take_audioPage.dart';
import 'package:p1_app/providers/animation_provider.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:p1_app/providers/recordAud_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AnimationProvider()),
      ChangeNotifierProvider(create: (context) => RecordAudProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteSongProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      initialRoute: "/take_audioPage",
      routes: {
        "/take_audioPage": (context) => take_audioPage(),
        "/favorite_songs": (context) => FavoriteSongs(),
      },
    );
  }
}
