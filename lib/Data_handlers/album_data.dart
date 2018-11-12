import 'package:flutter_app/Basic_elements/album.dart';
import 'package:flutter_app/audioPlayer.dart';

class AlbumData
{
  List<Album> listAlbum;
  AudioExtractor mAudioExtractor;
  AlbumData(this.listAlbum)
  {
    mAudioExtractor = new AudioExtractor();
  }

  List<Album> get albums{
    return listAlbum;
  }

  int get length
  {
    return listAlbum.length;
  }
}