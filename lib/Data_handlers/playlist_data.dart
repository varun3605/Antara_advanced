import 'package:flutter_app/Basic_elements/playlist.dart';
import 'package:flutter_app/audioPlayer.dart';

class PlaylistData
{
  List<Playlist> mPlayListList;
  AudioExtractor mAudioExtractor;
  PlaylistData(this.mPlayListList)
  {
    mAudioExtractor = new AudioExtractor();

  }

  List<Playlist> get genres{
    return mPlayListList;
  }

  int get length
  {
    return mPlayListList.length;
  }
}