
class Artist
{
  int id;
  String title;

  Artist(this.id, this.title);

  Artist.fromMap(Map m)
  {
    id = m["id"];
    title = m["title"];
  }
}