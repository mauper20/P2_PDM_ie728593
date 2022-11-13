import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p1_app/items/item_favouritesongs.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:provider/provider.dart';

class FavoriteSongs extends StatefulWidget {
  const FavoriteSongs({super.key});

  @override
  State<FavoriteSongs> createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  @override
  Widget build(BuildContext context) {
    final _favoriteList = Provider.of<FavoriteSongProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: listFav(context),
    );
  }

  ListView listFav(BuildContext context) {
    return ListView.builder(
        itemCount:
            context.watch<FavoriteSongProvider>().getaddedFavoriteteList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemMusic(
              inf: context
                  .watch<FavoriteSongProvider>()
                  .getaddedFavoriteteList[index]);
        });
  }
}
