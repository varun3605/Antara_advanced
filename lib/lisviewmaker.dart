import 'package:flutter/material.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';

SongData songData;
typedef songCallBack = void Function(Song);

class ListViewMaker extends StatefulWidget {
  final songCallBack selectedSong;

  ListViewMaker(SongData songDetail, {this.selectedSong}) {
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
          onTap: () {
            widget.selectedSong(s);
          },
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
