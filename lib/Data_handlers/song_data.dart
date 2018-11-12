import 'package:flutter_app/Basic_elements/song.dart';

class SongData {
  List<Song> listSong;
  SongData(this.listSong);

  List<Song> get songs {
    return listSong;
  }

  int get length {
    return listSong.length;
  }
}
