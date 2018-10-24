import 'package:flutter/material.dart';

class PlayList_List extends StatefulWidget
{
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new _PlayListsState();
    }
}

class _PlayListsState extends State<PlayList_List>
{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        body: Center(
          child: Text("In Playlists"),
        ),
      );
    } 
}