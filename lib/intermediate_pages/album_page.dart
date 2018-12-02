import 'package:flutter/material.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/audioPlayer.dart';
import 'package:flutter_app/lisviewmaker.dart';

int id;
String title;
var songs;
bool isLoading;
SongData songData;
typedef songCallBack = void Function(Song);

class AlbumPage extends StatefulWidget {
  final songCallBack onSelectedSong;

  AlbumPage(int albumId, String albumTitle, {this.onSelectedSong}) {
    id = albumId;
    title = albumTitle;
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
      backgroundColor: Colors.transparent,
      body: isLoading
          ? new CircularProgressIndicator()
          : ListViewMaker(
              songData,
              selectedSong: (song) {
                widget.onSelectedSong(song);
              },
            ),
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
