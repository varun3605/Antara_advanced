
class Genre
{
  int id;
  String title;

  Genre(this.id, this.title);

  Genre.fromMap(Map m)
  {
    id = m["id"];
    title = m["title"];
  }

}