import 'Basic_elements/genre.dart';
import 'audioPlayer.dart';

class GenreData
{
  List<Genre> mGenreList;
  AudioExtractor mAudioExtractor;
  GenreData(this.mGenreList)
  {
    mAudioExtractor = new AudioExtractor();

  }

  List<Genre> get genres{
    return mGenreList;
  }

  int get length
  {
    return mGenreList.length;
  }
}