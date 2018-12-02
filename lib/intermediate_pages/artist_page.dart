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

class ArtistPage extends StatefulWidget {
  final songCallBack onSelectedSong;

  ArtistPage(int artistId, String artistName, {this.onSelectedSong}) {
    id = artistId;
    title = artistName;
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
      backgroundColor: Colors.transparent,
      body: isLoading
          ? new CircularProgressIndicator()
          : ListViewMaker(songData, selectedSong: (song) {
              widget.onSelectedSong(song);
            }),
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
