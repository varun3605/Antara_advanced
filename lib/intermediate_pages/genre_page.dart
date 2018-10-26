import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/audioPlayer.dart';
import 'package:flutter_app/lisviewmaker.dart';

int id;
String title;
var songs;
bool isLoading;
SongData songData;


class GenrePage extends StatefulWidget {
  GenrePage(int id_genre, String genre_name) {
    id = id_genre;
    title = genre_name;
  }
  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
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
    songs = await AudioExtractor.getSongsFromGenre(id);
    print(songs);

    setState(() {
      songData = new SongData(songs);
      isLoading = false;
    });
  }
}
