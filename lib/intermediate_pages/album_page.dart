import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/audioPlayer.dart';
import 'package:flutter_app/lisviewmaker.dart';

int id;
String title;
var songs;
bool isLoading;
SongData songData;

class AlbumPage extends StatefulWidget {
  AlbumPage(int id_album, String album_title) {
    id = id_album;
    title = album_title;
  }
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: isLoading ? new CircularProgressIndicator() : ListViewMaker(songData),
    );
  }

  void getSongs() async {
    songs = await AudioExtractor.getSongsFromAlbum(id);
    print(songs);

    setState(() {
      songData = new SongData(songs);
      isLoading = false;
    });
  }
}
