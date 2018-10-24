
class Artist
{
  int id;
  String title;
  int noOfTracks;
  int noOfAlbums;

  Artist(this.id, this.title, this.noOfTracks, this.noOfAlbums);

  Artist.fromMap(Map m)
  {
    id = m["id"];
    title = m["title"];
    noOfAlbums = m["no_of_albums"];
    noOfTracks = m["no_of_tracks"];
  }
}