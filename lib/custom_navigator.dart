import 'package:flutter/material.dart';
import 'package:flutter_app/Basic_elements/album.dart';
import 'package:flutter_app/Basic_elements/artist.dart';
import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/intermediate_pages/album_page.dart';
import 'package:flutter_app/intermediate_pages/artist_page.dart';
import 'package:flutter_app/list_pages/album_list.dart';
import 'package:flutter_app/list_pages/artist_list.dart';

class CustomNavigatorRoutes {
  static const String albumRoot = '/albumroot';
  static const String albumDetail = '/albumdetail';
  static const String artistRoot = '/artistroot';
  static const String artistDetail = '/artistdetail';
}

typedef songCallBack = void Function(Song);
typedef indexCallBack = void Function(int);

// ignore: must_be_immutable
class CustomNavigator extends StatefulWidget {
  CustomNavigator(
      {this.navigatorKey,
      this.currentTabData,
      this.controllerData,
      this.index,
      this.returnIndex});

  final GlobalKey<NavigatorState> navigatorKey;
  var currentTabData;
  final songCallBack controllerData;
  final int index;
  final indexCallBack returnIndex;

  @override
  CustomNavigatorState createState() {
    return new CustomNavigatorState();
  }
}

class CustomNavigatorState extends State<CustomNavigator>
{
  _pushAlbumPage(BuildContext context, {Album selectedAlbum}) {
    var routeBuilder = _routeBuilder(context, selectedAlbum: selectedAlbum);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilder[CustomNavigatorRoutes.albumDetail](context)));
  }

  _pushArtistPage(BuildContext context, {Artist selectedArtist}) {
    var routeBuilder = _routeBuilder(context, selectedArtist: selectedArtist);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilder[CustomNavigatorRoutes.artistDetail](context)));
  }

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context,
      {var selectedAlbum, var selectedArtist}) {
    return {
      CustomNavigatorRoutes.albumRoot: (context) => AlbumsList(
            albumData: widget.currentTabData,
            onItemSelect: (album) {
              _pushAlbumPage(context, selectedAlbum: album);
              widget.returnIndex(1);
            },
          ),
      CustomNavigatorRoutes.albumDetail: (context) => AlbumPage(
            selectedAlbum.id,
            selectedAlbum.title,
            onSelectedSong: (song) {
              widget.controllerData(song);
            },
          ),
      CustomNavigatorRoutes.artistRoot: (context) => ArtistList(
            artistData: widget.currentTabData,
            onItemSelect: (artist) {
              _pushArtistPage(context, selectedArtist: artist);
              widget.returnIndex(2);
            },
          ),
      CustomNavigatorRoutes.artistDetail: (context) => ArtistPage(
            selectedArtist.id,
            selectedArtist.title,
            onSelectedSong: (song) {
              widget.controllerData(song);
            },
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilder = _routeBuilder(context);

    if (widget.index == 1) {
      return Navigator(
          key: widget.navigatorKey,
          initialRoute: CustomNavigatorRoutes.albumRoot,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilder[routeSettings.name](context));
          });
    }

    if (widget.index == 2) {
      return Navigator(
          key: widget.navigatorKey,
          initialRoute: CustomNavigatorRoutes.artistRoot,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilder[routeSettings.name](context));
          });
    }
  }
}
