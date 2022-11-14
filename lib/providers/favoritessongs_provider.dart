import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p1_app/pages/favorite_songs.dart';
import 'package:p1_app/pages/take_audioPage.dart';

class FavoriteSongProvider with ChangeNotifier {
  List<dynamic> _addedFavoriteteList = [];
  //we does use of propertys List to get  de content and is a list of objects
  List<dynamic> get getaddedFavoriteteList => _addedFavoriteteList;
  String? _uid = "";
  void dlateTrack(dynamic ObjecTrack) {
    _addedFavoriteteList.remove(ObjecTrack);
    notifyListeners();
  }

  void addTrack(dynamic ObjecTrack) {
    if (!_addedFavoriteteList.contains(ObjecTrack)) {
      _addedFavoriteteList.add(ObjecTrack);
      print(_addedFavoriteteList);
      notifyListeners();
    }
  }

  bool isInFavoriteList(dynamic musicObj) {
    return _addedFavoriteteList.contains(musicObj);
  }

  Widget Item_add(BuildContext context, dynamic objec) {
    return IconButton(
        onPressed: () {
          addFavorite(objec);
          print("favoritos");
          Navigator.of(context).pop(
            MaterialPageRoute(
              builder: (context) => FavoriteSongs(),
            ),
          );
          notifyListeners();
        },
        icon: Icon(Icons.favorite_border_outlined));
  }

  Widget Item_Delate(BuildContext context, dynamic objec) {
    return IconButton(
        onPressed: () {
          print("La cancion es favorita? ${isInFavoriteList(objec)}");
          showDialog(
              context: context,
              builder: (builder) => AlertDialog(
                    title: Text("Eliminar de favoritos"),
                    content: Text("El elemento será eliminado de sus favorito"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("abortar")),
                      TextButton(
                          onPressed: () {
                            deleteFavorite(objec);
                            print("favoritos");
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                builder: (context) => take_audioPage(),
                              ),
                            );
                            notifyListeners();
                          },
                          child: Text("delete"))
                    ],
                  ));
        },
        icon: Icon(Icons.favorite, color: Colors.red));
  }

  //----------------------------------------------------------------------------------

  void addFavorite(dynamic musicObj) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "favorites": FieldValue.arrayUnion([musicObj]),
      'user_id': FirebaseAuth.instance.currentUser!.uid
    });
    getSongsList();
    notifyListeners();
  }

  void takeFavoritesongList() async {
    getSongsList();
    notifyListeners();
  }

  void deleteFavorite(dynamic musicObj) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "favorites": FieldValue.arrayRemove([musicObj]),
      'user_id': FirebaseAuth.instance.currentUser!.uid
    });
    getSongsList();
    notifyListeners();
  }

  void getSongsList() async {
    var myCollection = await FirebaseFirestore.instance
        .collection('user')
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    var mySongs = myCollection.docs.first.data()['favorites'];
    log(mySongs.toString());
    _addedFavoriteteList = mySongs;
    notifyListeners();
    return;
  }
}
