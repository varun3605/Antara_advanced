import 'package:flutter/material.dart';
import 'package:flutter_app/drawer/menu_controller.dart';
import 'package:flutter_app/library.dart';
import 'drawer_menu_item.dart';

class MenuScreen extends StatefulWidget {

  final Menu menu;
  final String currrentSelectedItemId;
  final Function(String) onMenuItemSelected;

  MenuScreen({this.menu, this.currrentSelectedItemId,this.onMenuItemSelected});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMenuController(
        builder: (BuildContext context, MenuController menuController) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/green_leaf.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                createMenuItems(menuController),
              ],
            )),
      );
    });
  }

  createMenuItems(MenuController menuController) {

    final List<Widget> listItems = [];

    for (var i = 0; i < widget.menu.items.length; ++i) {
      listItems.add(
        DrawerListItem(
          title: widget.menu.items[i].title,
          isSelected: widget.menu.items[i].id == widget.currrentSelectedItemId,
          onTap: () {
            widget.onMenuItemSelected(widget.menu.items[i].id);
            menuController.close();

          },
        ),
      );
    }

    return Transform(
      transform: Matrix4.translationValues(0.0, 225.0, 0.0),
      child: Column(
        children: listItems,
      ),
    );
  }
}

class Menu {
  final List<MenuItem> items;

  Menu({this.items});
}

class MenuItem {
  final String id;
  final String title;

  MenuItem({this.id, this.title});
}
