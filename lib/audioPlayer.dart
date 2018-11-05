import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/Basic_elements/album.dart';
import 'package:flutter_app/Basic_elements/artist.dart';
import 'Basic_elements/genre.dart';
import 'Basic_elements/playlist.dart';

typedef void TimeHandler(Duration duration);
typedef void ErrorHandler(String message);

class AudioExtractor {
  static const MethodChannel _channel =
      const MethodChannel('com.hvr.mainapp/audiofinder'); // Specifying Method Channel with name

  TimeHandler durnHandler;
  TimeHandler poshandler;
  ErrorHandler errorHandler;
  VoidCallback startHandler;
  VoidCallback completeHandler;

  AudioExtractor() {
    _channel.setMethodCallHandler(audioCallHandler);
  }

  Future<dynamic> audioCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "media.duration":
        final duration = new Duration(milliseconds: methodCall.arguments);
        if (durnHandler != null) {
          durnHandler(duration);
        }
        break;

      case "media.onCurrentPosn":
        if (poshandler != null) {
          poshandler(new Duration(milliseconds: methodCall.arguments));
        }
        break;

      case "media.onStart":
        if (startHandler != null) startHandler();
        break;

      case "media.onComplete":
        if (completeHandler != null) {
          completeHandler();
        }
        break;

      case "media.onError":
        if (errorHandler != null) {
          errorHandler(methodCall.arguments);
        }
        break;

      default:
        print('Unknown method ${methodCall.method} ');
    }
  }

  void setDurnhandler(TimeHandler handler) {
    durnHandler = handler;
  }

  void setPoshandler(TimeHandler handler) {
    poshandler = handler;
  }

  void setStarthandler(VoidCallback callback) {
    startHandler = callback;
  }

  void setCompleteHandler(VoidCallback callback) {
    completeHandler = callback;
  }

  void setErrorhandler(ErrorHandler handler) {
    errorHandler = handler;
  }

  Future<dynamic> play(String uri, {bool isLocal: false}) {
    return _channel.invokeMethod('play', {"uri": uri, "isLocal": isLocal});
  }

  Future<dynamic> pause() {
    return _channel.invokeMethod('pause');
  }

  Future<dynamic> stop() {
    return _channel.invokeMethod('stop');
  }

  Future<dynamic> mute(bool muted) {
    return _channel.invokeMethod('mute', muted);
  }

  Future<dynamic> seek(double second) {
    return _channel.invokeMethod('seek', second);
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> requestPermission(int key) async//8. Invoking Method Channel for Request Permissions
  {
    final String permission_rqst_status = await _channel.invokeMethod('request_permissions', {"status" : key});
    return permission_rqst_status;
  }

  static Future<String> openSettings() async
  {
    final String per_current_status = await _channel.invokeMethod('open_settings');
    return per_current_status;
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

  static Future<dynamic> allPlaylists() async{
    var completer = new Completer();

    List<dynamic> playlists = await _channel.invokeMethod('getPlaylists');
    print(playlists.runtimeType);

    var allPlaylists = playlists.map((m) {
      return new Playlist.fromMap(m);
    }).toList();

    completer.complete(allPlaylists);
    return completer.future;
  }

  static Future<dynamic> getSongsFromAlbum( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsfromAlbum',{"id":id});
    print(songs.runtimeType);

    var Songs = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(Songs);
    return completer.future;
  }

  static Future<dynamic> getSongsFromArtist( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsfromArtist',{"id":id});
    print(songs.runtimeType);

    var Songs = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(Songs);
    return completer.future;
  }

  static Future<dynamic> getSongsFromGenre( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsfromGenre',{"id":id});
    print(songs.runtimeType);

    var Songs = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(Songs);
    return completer.future;
  }

  static Future<dynamic> getSongsFromPlaylist( int id) async{
    var completer = new Completer();

    List<dynamic> songs = await _channel.invokeMethod('getSongsfromPlaylist',{"id":id});
    print(songs.runtimeType);

    var Songs = songs.map((m) {
      return new Song.fromMap(m);
    }).toList();

    completer.complete(Songs);
    return completer.future;
  }
}
