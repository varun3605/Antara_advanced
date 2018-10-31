import 'package:flutter/material.dart';
import 'package:flutter_app/Data_handlers/artist_data.dart';
import 'package:flutter_app/intermediate_pages/artist_page.dart';

ArtistData artistData;

class ArtistList extends StatefulWidget {
  ArtistList(ArtistData artistDetail) {
    artistData = artistDetail;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _artistState();
  }
}

class _artistState extends State<ArtistList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GridView.builder(
        itemCount: artistData.mListArtist.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int i) {
          var a = artistData.mListArtist[i];

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
                          color: Colors.white,
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
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new ArtistPage(a.id, a.title);
              }));
            },
          );
        });
  }
}
