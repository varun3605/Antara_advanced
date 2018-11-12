import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;

  DrawerListItem({this.title, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellowAccent,
      onTap: isSelected? null: onTap,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
          child: Text(
            title,
            style: new TextStyle(
              color: isSelected? Colors.blue: Colors.white,
              fontSize: 20.0,
              fontFamily: 'K2D',
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
