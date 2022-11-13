import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteSongProvider with ChangeNotifier {
  final List<dynamic> _addedFavoriteteList = [];
  //we does use of propertys List to get  de content and is a list of objects
  List<dynamic> get getaddedFavoriteteList => _addedFavoriteteList;

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
          addTrack(objec);
          Navigator.of(context).pushNamed("/favorite_songs");
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
                            Navigator.of(context).pop();
                            dlateTrack(objec);
                            Navigator.of(context).pushNamed("/take_audioPage");
                            notifyListeners();
                          },
                          child: Text("delete"))
                    ],
                  ));
        },
        icon: Icon(Icons.favorite));
  }
}
