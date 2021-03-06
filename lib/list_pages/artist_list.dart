import 'package:flutter/material.dart';
import 'package:flutter_app/Basic_elements/artist.dart';
import 'package:flutter_app/Data_handlers/artist_data.dart';
import 'package:flutter_app/intermediate_pages/artist_page.dart';

typedef artistCallBack = void Function(Artist);

class ArtistList extends StatefulWidget {
  final artistCallBack onItemSelect;
  final ArtistData artistData;

  ArtistList({this.artistData, this.onItemSelect});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ArtistState();
  }
}

class _ArtistState extends State<ArtistList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GridView.builder(
        itemCount: widget.artistData.mListArtist.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int i) {
          var a = widget.artistData.mListArtist[i];

          return new GestureDetector(
            child: new Stack(
              children: <Widget>[
                new Material(
                  child: Container(
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
                      /*  Text(
                        a.id.toString()
                      ),*/
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
