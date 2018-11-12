import 'package:flutter/material.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/drawer/menu_controller.dart';
import 'package:flutter_app/library.dart';
import 'dart:io';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'audioPlayer.dart';

Song song;
typedef songCallBack = void Function(Song);
var songs, albums, artists, genres, playLists, artFile;
SongData songData;
AlbumData albumData;
ArtistData artistData;
GenreData genreData;
PlaylistData playlistData;
String songTitle, albumArt, songArtist;
bool isTapped, isPlaying;
SharedPreferences preferences;
IconData icon;

class TabPage extends StatefulWidget {
  bool isLoading;

  TabPage({this.isLoading});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Song> songs;

  @override
  void initState() {
    isTapped = false;
    if(widget.isLoading)
      loadSongs();
    getTapState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getTapState() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isTapped = (preferences.getBool('tap_state') ?? false);
      songTitle = (preferences.getString('song_title_stored') ?? " ");
      songArtist = (preferences.getString('song_artist_stored') ?? " ");
      isPlaying = false;
      isPlaying ? icon = Icons.pause : icon = Icons.play_arrow;
      albumArt = preferences.getString('album_art_stored');
      artFile = albumArt == null ? null : new File.fromUri(Uri.parse(albumArt));
    });
  }

  loadSongs() async {
    songs = await AudioExtractor.allSongs();
    albums = await AudioExtractor.allAlbums();
    artists = await AudioExtractor.allArtists();
    genres = await AudioExtractor.allGenres();
    playLists = await AudioExtractor.allPlayLists();
    print(songs);
    print(albums);
    print(artists);
    print(genres);
    print(playLists);
    if (!mounted) return;

    setState(() {
      songData = new SongData(songs);
      albumData = new AlbumData(albums);
      artistData = new ArtistData(artists);
      genreData = new GenreData(genres);
      playlistData = new PlaylistData(playLists);
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMenuController(
        builder: (BuildContext context, MenuController menuController) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "images/green_leaf.jpg",
              fit: BoxFit.cover,
              //color: Colors.black45,
              //colorBlendMode: BlendMode.multiply,
            ),
            Padding(
              padding: isTapped
                  ? EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 68.0)
                  : EdgeInsets.all(0.0),
              child: tabPage(menuController),
            ),
            isTapped ? controller() : new Container(),
          ],
        ),
      );
    });
  }

  appbar(MenuController menuController) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          menuController.toggle();
        },
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: new Text(
        "Library",
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        )
      ],
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
    );
  }

  tabPage(MenuController menuController) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appbar(menuController),
        body: widget.isLoading
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new TabBarView(
                children: <Widget>[
                  new TracksList(
                    songData,
                    callback: (Song song) {
                      setState(() {
                        songTitle = song.title;
                        songArtist = song.artist;
                        artFile = song.albumArt == null
                            ? null
                            : new File.fromUri(Uri.parse(song.albumArt));
                        preferences.setBool('tap_state', true);
                        preferences.setString('song_title_stored', songTitle);
                        preferences.setString(
                            'album_art_stored', song.albumArt);
                        preferences.setString('song_artist_stored', songArtist);
                        isTapped = true;
                        isPlaying = true;
                        isPlaying
                            ? icon = Icons.pause
                            : icon = Icons.play_arrow;
                      });
                    },
                  ),
                  new AlbumsList(albumData),
                  new ArtistList(artistData),
                  new PlayListList(playlistData),
                  new GenreList(genreData)
                ],
              ),
      ),
    );
  }

  controller() {
    return Positioned(
      bottom: 0.0,
      height: 68.0,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: ListTileTheme(
          contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
          child: ListTile(
            leading: new Material(
              color: Colors.transparent,
              child: artFile != null
                  ? Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
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
            title: Text(
              songTitle,
              maxLines: 1,
              softWrap: false,
            ),
            subtitle: Text(
              songArtist,
              maxLines: 1,
              softWrap: false,
            ),
            trailing: IconButton(
              icon: Icon(
                icon,
                color: Colors.white,
                size: 36.0,
              ),
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                  isPlaying ? icon = Icons.pause : icon = Icons.play_arrow;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
