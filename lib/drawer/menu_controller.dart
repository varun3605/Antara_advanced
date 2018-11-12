import 'package:flutter/material.dart';

enum MenuState{closed, closing, open, opening}


class MenuController extends ChangeNotifier
{
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState menuState = MenuState.closed;

  MenuController({this.vsync}):_animationController = new AnimationController(vsync: vsync){
    _animationController..duration = const Duration(milliseconds: 300)
        ..addListener((){
          notifyListeners();
        })
        ..addStatusListener((AnimationStatus status)
        {
          switch(status){
            case AnimationStatus.forward:
              menuState = MenuState.opening;
              break;
            case AnimationStatus.reverse:
              menuState = MenuState.closing;
              break;
            case AnimationStatus.completed:
              menuState = MenuState.open;
              break;
            case AnimationStatus.dismissed:
              menuState = MenuState.closed;
              break;
          }
          notifyListeners();
        });
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen
  {
    return _animationController.value;
  }

  open()
  {
    _animationController.forward();
  }

  close()
  {
    _animationController.reverse();
  }

  toggle()
  {
    if(menuState == MenuState.open)
      close();
    else if(menuState == MenuState.closed)
      open();
  }
}
