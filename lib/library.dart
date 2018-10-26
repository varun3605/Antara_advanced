import 'package:flutter/material.dart';
import 'package:flutter_app/Tablayout_library.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';


class Library extends StatefulWidget {
  Library();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _libraryState();
  }
}

class _libraryState extends State<Library> {
  List<Song> songs;
  String primaryTitle = 'Antara';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new TabPage(),
    );
  }
}
