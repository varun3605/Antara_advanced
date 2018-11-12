import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/audioPlayer.dart';
import 'package:flutter_app/lisviewmaker.dart';

int id;
String title;
var songs;
bool isLoading;
SongData songData;


class PlaylistPage extends StatefulWidget {
  PlaylistPage(int playlistId, String playlistName) {
    id = playlistId;
    title = playlistName;
  }
  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
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
    songs = await AudioExtractor.getSongsFromPlaylist(id);
    print(songs);

    setState(() {
      songData = new SongData(songs);
      isLoading = false;
    });
  }
}
