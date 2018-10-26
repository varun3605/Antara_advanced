import 'package:flutter_app/Basic_elements/playlist.dart';
import 'package:flutter_app/audioPlayer.dart';

class PlaylistData
{
  List<Playlist> mPlayList_list;
  AudioExtractor mAudioExtractor;
  PlaylistData(this.mPlayList_list)
  {
    mAudioExtractor = new AudioExtractor();

  }

  List<Playlist> get genres{
    return mPlayList_list;
  }

  int get length
  {
    return mPlayList_list.length;
  }
}