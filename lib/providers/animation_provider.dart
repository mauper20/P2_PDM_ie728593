import 'package:flutter/cupertino.dart';

class AnimationProvider with ChangeNotifier {
  bool _animation = false;
  String _action = "Toca para Escuchar";
  bool get getAnimation => _animation;
  String get action => _action;

  void changeAnimation(bool flag) {
    if (flag) {
      _animation = !_animation;
      if (_animation == true) {
        _action = "Escuchando...";
      }
    } else {
      _animation = false;
      _action = "Toca para Escuchar";
    }

    notifyListeners();
  }
}
