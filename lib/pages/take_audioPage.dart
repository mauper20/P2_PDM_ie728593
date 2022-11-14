import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p1_app/auth/bloc/auth_bloc.dart';
import 'package:p1_app/pages/favorite_songs.dart';
import 'package:p1_app/pages/infomusic_page.dart';
import 'package:p1_app/providers/animation_provider.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:p1_app/providers/recordAud_provider.dart';
import 'package:provider/provider.dart';

class take_audioPage extends StatelessWidget {
  const take_audioPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infRes;
    final _animProvid = Provider.of<AnimationProvider>(context);
    final _audRc = Provider.of<RecordAudProvider>(context);
    var _favoriteList = Provider.of<FavoriteSongProvider>(context);
    late SnackBar snackBar;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            _animProvid.action,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          AvatarGlow(
            animate: context.read<AnimationProvider>().getAnimation,
            glowColor: Colors.pink,
            endRadius: 170,
            repeat: true,
            showTwoGlows: true,
            duration: Duration(milliseconds: 2000),
            repeatPauseDuration: Duration(milliseconds: 1000),
            child: MaterialButton(
              elevation: 20,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 90.0,
                backgroundImage: AssetImage('assets/images/voice-recorder.png'),
              ),
              onPressed: () async {
                bool flag = true;
                print("object");
                _animProvid.changeAnimation(flag);
                infRes = await context.read<RecordAudProvider>().startRecord();
                flag = false;
                _animProvid.changeAnimation(flag);
                print("esta : $infRes");
                if (infRes.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DataMusic(
                            inf: infRes,
                          )));
                } else {
                  snackBar = const SnackBar(
                    backgroundColor: Colors.deepPurpleAccent,
                    content: Text(
                      "Lo sentimos, hubo un error. Intenta de nuevo.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 25,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _favoriteList.takeFavoritesongList();
                    print("favoritos");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavoriteSongs(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                        title: Text("Sign out"),
                        content: Text(
                            "El cierre de su sesion lo llevara a la pantalla de inicio,¿Quieres continuar?"),
                        actions: [
                          TextButton(
                            child: Text("abortar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Cerrar sesión"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutEvent());
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    radius: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
