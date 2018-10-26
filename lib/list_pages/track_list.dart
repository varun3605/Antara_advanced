import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/Data_handlers/song_data.dart';

SongData songData;

class TracksList extends StatefulWidget {
  TracksList(SongData songDetail) {
    songData = songDetail;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _trackState();
  }
}

class _trackState extends State<TracksList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: songData.list_song.length,
      itemBuilder: (context, int i) {
        var s = songData.list_song[i];

        var artFile =
            s.albumArt == null ? null : new File.fromUri(Uri.parse(s.albumArt));
        print(s);
        return new ListTile(
          leading: new Material(
            child: artFile != null
                ? Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      image: new DecorationImage(
                        image: new FileImage(artFile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : new CircleAvatar(
                    child: new Icon(Icons.play_circle_filled),
                  ),
          ),
          title: new Text(s.title),
          trailing: new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: null,
          ),
        );
      },
    );
  }
}
