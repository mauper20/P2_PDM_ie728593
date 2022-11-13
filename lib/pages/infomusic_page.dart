import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DataMusic extends StatelessWidget {
  final Map inf;

  const DataMusic({super.key, required this.inf});

  @override
  Widget build(BuildContext context) {
    final _favorsong = Provider.of<FavoriteSongProvider>(context);
    bool _favoriteYN = _favorsong.isInFavoriteList(inf);

    Future<void> _gotoUrll(Url) async {
      if (!await launchUrl(Uri.parse(Url))) {
        throw 'Could not launch ';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Here you go"),
        actions: [
          _favoriteYN
              ? context.read<FavoriteSongProvider>().Item_Delate(context, inf)
              : context.read<FavoriteSongProvider>().Item_add(context, inf)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.network(
              "${inf["spotify"]["album"]["images"][0]["url"]}",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${inf["title"]}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${inf["album"]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${inf["artist"]}",
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
                Text(
                  "${inf["release_date"]}",
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: Color.fromARGB(255, 180, 176, 176),
          ),
          Text("Abrir con:"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  _gotoUrll(inf["spotify"]["external_urls"]["spotify"]);
                },
                child: Icon(
                  FontAwesomeIcons.spotify,
                  size: 40,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _gotoUrll(inf["song_link"]);
                },
                child: Icon(
                  FontAwesomeIcons.podcast,
                  size: 50,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _gotoUrll(inf["apple_music"]["url"]);
                },
                child: Icon(
                  FontAwesomeIcons.apple,
                  size: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
