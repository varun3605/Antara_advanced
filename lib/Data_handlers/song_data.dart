import 'package:flutter_app/Basic_elements/song.dart';
import 'package:flutter_app/audioPlayer.dart';

class SongData {
  List<Song> list_song;
  AudioExtractor mAudioExtractor;
  SongData(this.list_song) {
    mAudioExtractor = new AudioExtractor();
  }

  List<Song> get songs {
    return list_song;
  }

  int get length {
    return list_song.length;
  }
}
