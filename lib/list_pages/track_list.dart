import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/Basic_elements/song.dart';

SongData songData;
typedef songCallBack = void Function(Song);
songCallBack onItemSelect;

class TracksList extends StatefulWidget {
  final songCallBack callback;

  TracksList(SongData songDetail, {this.callback}) {
    songData = songDetail;
    onItemSelect = callback;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TrackState();
  }
}

class _TrackState extends State<TracksList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: songData.listSong.length,
      itemBuilder: (context, int i) {
        var s = songData.listSong[i];

        var artFile =
        s.albumArt == null ? null : new File.fromUri(Uri.parse(s.albumArt));
        return new ListTileTheme(
          contentPadding: EdgeInsets.only(
            left: 16.0,
          ),
          child: ListTile(
            onTap: () {
              onItemSelect(songData.listSong[i]);
            },
            leading: new Material(
              color: Colors.transparent,
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
                  : new Container(
                width: 48.0,
                height: 48.0,
                child: Center(
                  child: new Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 48.0,
                  ),
                ),
              ),
            ),
            title: new Text(
              s.title,
              softWrap: false,
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
            subtitle: new Text(
              s.artist,
              maxLines: 1,
            ),
            trailing: new IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ),
        );
      },
    );
  }
}
