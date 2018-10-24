class Album
{
  int id;
  String title;
  int numSongs;
  String artist;
  int firstYear;
  int lastYear;
  String albumArt;

  Album(this.albumArt, this.artist, this.firstYear, this.id, this.lastYear, this.numSongs, this.title);

  Album.fromMap(Map m)
  {
    id = m["id"];
    title = m["title"];
    albumArt = m["albumArt"];
    numSongs = m["number_songs"];
    firstYear = m["first_year"];
    artist = m["artist"];
    lastYear = m["last_year"];
  }
}