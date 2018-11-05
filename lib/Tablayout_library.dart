import 'package:flutter/material.dart';
import 'package:flutter_app/list_pages/album_list.dart';
import 'package:flutter_app/list_pages/artist_list.dart';
import 'package:flutter_app/list_pages/genre_list.dart';
import 'package:flutter_app/list_pages/playlist_list.dart';
import 'package:flutter_app/list_pages/track_list.dart';
import 'package:flutter_app/Data_handlers/song_data.dart';
import 'package:flutter_app/Data_handlers/album_data.dart';
import 'package:flutter_app/Data_handlers/artist_data.dart';
import 'package:flutter_app/Data_handlers/genre_data.dart';
import 'Data_handlers/playlist_data.dart';
import 'audioPlayer.dart';

var songs, albums, artists, genres, playlists;
SongData songData;
AlbumData albumData;
ArtistData artistData;
GenreData genreData;
PlaylistData playlistData;
bool isLoading;

class TabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: 5,
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: new Text("Library"),
          bottom: new TabBar(
            isScrollable: true,
            tabs: <Widget>[
              new Tab(text: "Tracks"),
              new Tab(text: "Albums"),
              new Tab(text: "Artists"),
              new Tab(text: "Playlists"),
              new Tab(text: "Genres")
            ],
          ),
        ),
        body: isLoading
            ? new CircularProgressIndicator()
            : new TabBarView(
                children: <Widget>[
                  new TracksList(songData),
                  new AlbumsList(albumData),
                  new ArtistList(artistData),
                  new PlayList_List(playlistData),
                  new GenreList(genreData)
                ],
              ),
      ),
    );
  }

  void loadSongs() async {
    songs = await AudioExtractor.allSongs();
    albums = await AudioExtractor.allAlbums();
    artists = await AudioExtractor.allArtists();
    genres = await AudioExtractor.allGenres();
    playlists = await AudioExtractor.allPlaylists();
    print(songs);
    print(albums);
    print(artists);
    print(genres);
    print(playlists);
    if (!mounted) return;

    setState(() {
      songData = new SongData(songs);
      albumData = new AlbumData(albums);
      artistData = new ArtistData(artists);
      genreData = new GenreData(genres);
      playlistData = new PlaylistData(playlists);
      isLoading = false;
    });
  }
}
