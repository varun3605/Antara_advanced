import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/playlist_data.dart';
import 'package:flutter_app/intermediate_pages/playlist_page.dart';

PlaylistData playlistData;

class PlayListList extends StatefulWidget
{
  PlayListList(PlaylistData playListDetail)
  {
    playlistData = playListDetail;
  }
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new _PlayListsState();
    }
}

class _PlayListsState extends State<PlayListList>
{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
    return new ListView.builder(
      itemCount: playlistData.mPlayListList.length+1,
      itemBuilder: (context, int i) {
        if(i>0) {
          var p = playlistData.mPlayListList[i - 1];
          print(p);
          return new ListTile(
            title: new Text(p.title),
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new PlaylistPage(p.id, p.title);
              }));
            },
          );
        }
        else
          {
            return new ListTile(
              title: new Text("Create New Playlist"),
            );
          }

      },
    );
    } 
}