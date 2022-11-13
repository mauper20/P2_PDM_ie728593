import 'package:flutter/material.dart';
import 'package:p1_app/pages/infomusic_page.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:provider/provider.dart';

class ItemMusic extends StatelessWidget {
  const ItemMusic({super.key, required this.inf});
  final Map inf;

  @override
  Widget build(BuildContext context) {
    final _favorsong = Provider.of<FavoriteSongProvider>(context);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: MaterialButton(
              color: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DataMusic(
                          inf: inf,
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "${inf["spotify"]["album"]["images"][0]["url"]!}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 17.5 / 20,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    Text(
                      "${inf["title"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${inf["artist"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _favorsong.Item_Delate(context, inf)
        ],
      ),
    );
  }
}
