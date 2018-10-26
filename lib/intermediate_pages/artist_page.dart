import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/audioPlayer.dart';
import 'package:flutter_app/lisviewmaker.dart';

int id;
String title;
var songs;
bool isLoading;
SongData songData;


class ArtistPage extends StatefulWidget {
  ArtistPage(int id_artist, String artist_name) {
    id = id_artist;
    title = artist_name;
  }
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
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
    songs = await AudioExtractor.getSongsFromArtist(id);
    print(songs);

    setState(() {
      songData = new SongData(songs);
      isLoading = false;
    });
  }
}
