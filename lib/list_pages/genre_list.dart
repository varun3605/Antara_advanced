import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/genre_data.dart';
import 'package:flutter_app/intermediate_pages/genre_page.dart';

GenreData genreData;

class GenreList extends StatefulWidget {
  GenreList(GenreData genreDetail) {
    genreData = genreDetail;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GenreState();
  }
}

class _GenreState extends State<GenreList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: genreData.mGenreList.length,
      itemBuilder: (context, int i) {
        var g = genreData.mGenreList[i];
        print(g);
        return new ListTile(
          title: new Text(g.title),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new GenrePage(g.id, g.title);
            }));
          },
        );
      },
    );
  }
}
