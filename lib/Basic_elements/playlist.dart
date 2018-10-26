
class Playlist
{
  int id;
  String title;
  int dateAdded;
  int dateModified;

  Playlist(this.id, this.title, this.dateAdded, this.dateModified);

  Playlist.fromMap(Map m)
  {
    id = m["id"];
    title = m["title"];
    dateAdded = m["date_added"];
    dateModified = m["date_modified"];
  }

}