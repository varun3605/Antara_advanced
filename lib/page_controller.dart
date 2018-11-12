import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/drawer/menu_controller.dart';
import 'package:flutter_app/library.dart';
import 'package:flutter_app/tab_page.dart';

class PageViewController extends StatelessWidget {
  final String selectedMenuItemId;
  final bool setIsLoading;

  PageViewController({this.selectedMenuItemId, this.setIsLoading});

  @override
  Widget build(BuildContext context) {
    switch (selectedMenuItemId) {
      case '0':
        return TabPage(
          isLoading: setIsLoading,
        );
        break;
      default:
        return ScaffoldMenuController(
            builder: (BuildContext context, MenuController menuController) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/ocean.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text('OTHER SCREEN'),
                  leading: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      menuController.toggle();
                    },
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          );
        });
    }
  }
}
