class Song {
  int id;
  String artist;
  String title;
  String album;
  int albumId;
  int duration;
  String uri;
  String albumArt;
  int size;
  int dateModified;
  String type;
  int year;
  String composer;
  int track;

  Song(this.id, this.artist, this.title, this.album, this.albumId,
      this.duration, this.uri, this.albumArt, this.size, this.composer, this.dateModified, this.track,
      this.type, this.year);

  Song.fromMap(Map m) {
    id = m["id"];
    artist = m["artist"];
    title = m["title"];
    album = m["album"];
    albumId = m["albumId"];
    duration = m["duration"];
    uri = m["uri"];
    albumArt = m["albumArt"];
    size = m["size"];
    composer = m["composer"];
    dateModified = m["date_modified"];
    track = m["track_no"];
    type = m["song_type"];
    year = m["year"];
  }
}
