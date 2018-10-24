import 'package:flutter_app/Basic_elements/album.dart';
import 'audioPlayer.dart';

class AlbumData
{
  List<Album> list_album;
  AudioExtractor mAudioExtractor;
  AlbumData(this.list_album)
  {
    mAudioExtractor = new AudioExtractor();
  }

  List<Album> get albums{
    return list_album;
  }

  int get length
  {
    return list_album.length;
  }
}