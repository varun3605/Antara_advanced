import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
    textTheme: TextTheme(
      subhead: TextStyle(
        fontFamily: 'list_item_title',
        color: Colors.white,
        fontSize: 17.0,
      ),
      body1: TextStyle(
        fontFamily: 'list_item_subtitle',
        fontSize: 14.0,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'list_item_title',
      ),
      body2: TextStyle(
        fontFamily: 'list_item_title',
      ),
    ),
  );
