import 'package:flutter/material.dart';
import 'package:flutter_app/Tablayout_library.dart';
import 'package:flutter_app/Basic_elements/song.dart';



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
    return new Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/ocean.jpg",
            fit: BoxFit.cover,
          ),
          TabPage(),
        ],
      ),
    );
  }
}
