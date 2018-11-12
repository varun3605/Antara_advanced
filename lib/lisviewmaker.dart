import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';

SongData songData;

class ListViewMaker extends StatefulWidget {
  ListViewMaker(SongData songDetail) {
    songData = songDetail;
  }
  @override
  _ListViewMakerState createState() => _ListViewMakerState();
}

class _ListViewMakerState extends State<ListViewMaker> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: songData.listSong.length,
      itemBuilder: (context, int i) {
        var s = songData.listSong[i];

        print(s);
        return new ListTile(
          title: new Text(s.title),
          trailing: new IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        );
      },
    );
  }
}
