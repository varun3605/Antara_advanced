import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/Basic_elements/album.dart';
import 'package:flutter_app/Basic_elements/artist.dart';
import 'Basic_elements/genre.dart';
import 'Basic_elements/playlist.dart';

class AudioExtractor {
  static const MethodChannel _channel =
      const MethodChannel('com.hvr.flutterApp/audioFinder'); // Specifying Method Channel with name

    static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> requestPermission(int key) async//8. Invoking Method Channel for Request Permissions
  {
    final String perRequestStatus = await _channel.invokeMethod('request_permissions', {"status" : key});
    return perRequestStatus;
  }

  static Future<String> openSettings() async
  {
    final String perCurrentStatus = await _channel.invokeMethod('open_settings');
    return perCurrentStatus;
  }
  static Future<dynamic> allSongs() async {
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongs');
    print(songs.runtimeType);

    var allSongs = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(allSongs);
    return completer.future;
  }

  static Future<dynamic> allAlbums() async{
    var completer = new Completer();

    List<dynamic> albums = await _channel.invokeMethod('getAlbums');
    print(albums.runtimeType);

    var allAlbums = albums.map((m) {
      return new Album.fromMap(m);
    }).toList();

    completer.complete(allAlbums);
    return completer.future;
  }

  static Future<dynamic> allArtists() async{
    var completer = new Completer();

    List<dynamic> artists = await _channel.invokeMethod('getArtists');
    print(artists.runtimeType);

    var allArtists = artists.map((m) {
      return new Artist.fromMap(m);
    }).toList();

    completer.complete(allArtists);
    return completer.future;
  }

  static Future<dynamic> allGenres() async{
    var completer = new Completer();

    List<dynamic> genres = await _channel.invokeMethod('getGenres');
    print(genres.runtimeType);

    var allGenres = genres.map((m) {
      return new Genre.fromMap(m);
    }).toList();

    completer.complete(allGenres);
    return completer.future;
  }

  static Future<dynamic> allPlayLists() async{
    var completer = new Completer();

    List<dynamic> playLists = await _channel.invokeMethod('getPlayLists');
    print(playLists.runtimeType);

    var allPlayLists = playLists.map((m) {
      return new Playlist.fromMap(m);
    }).toList();

    completer.complete(allPlayLists);
    return completer.future;
  }

  static Future<dynamic> getSongsFromAlbum( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsFromAlbum',{"id":id});
    print(songs.runtimeType);

    var songList = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(songList);
    return completer.future;
  }

  static Future<dynamic> getSongsFromArtist( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsFromArtist',{"id":id});
    print(songs.runtimeType);

    var songList = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(songList);
    return completer.future;
  }

  static Future<dynamic> getSongsFromGenre( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsFromGenre',{"id":id});
    print(songs.runtimeType);

    var songList = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(songList);
    return completer.future;
  }

  static Future<dynamic> getSongsFromPlaylist( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsFromPlaylist',{"id":id});
    print(songs.runtimeType);

    var songList = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(songList);
    return completer.future;
  }
}
