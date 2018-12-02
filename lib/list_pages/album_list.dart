import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/album_data.dart';
import 'package:flutter_app/intermediate_pages/album_page.dart';
import 'package:flutter_app/Basic_elements/album.dart';
import 'dart:io';

typedef albumCallBack = void Function(Album);

class AlbumsList extends StatefulWidget {

  final albumCallBack onItemSelect;
  final AlbumData albumData;
  AlbumsList({this.albumData, this.onItemSelect});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AlbumState();
  }
}

class _AlbumState extends State<AlbumsList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GridView.builder(
        itemCount: widget.albumData.listAlbum.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int i) {
          var a = widget.albumData.listAlbum[i];

          var artFile = a.albumArt == null
              ? null
              : new File.fromUri(Uri.parse(a.albumArt));
          return new GestureDetector(
            child: new Stack(
              children: <Widget>[
                new Material(
                  child: artFile != null
                      ? Image.file(
                          artFile,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.blue,
                        ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        a.title,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              widget.onItemSelect(a);
            },
          );
        });
  }
}
