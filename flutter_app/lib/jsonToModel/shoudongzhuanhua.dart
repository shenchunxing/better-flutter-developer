class Person {
  String? name;
  String? avatarURL;

  Person.fromMap(Map<String , dynamic> json) {
    this.name = json['name'];
    this.avatarURL = json['avatars']['medium'];
  }
}

class Actor extends Person {
  Actor.fromMap(Map<String ,dynamic> json):super.fromMap(json);
}

class Director extends Person {
  Director.fromMap(Map<String , dynamic> json) : super.fromMap(json);
}

int counter = 1;

class MovieItem {
  int rank = 0;
  String? imageURL;
  String? title;
  String? playDate;
  double rating = 0;
  List<String>? genres;
  List<Actor>? casts;
  Director? director;
  String? originalTitle = '';

  //json转模型
  MovieItem.fromMap(Map<String ,dynamic> json) {
    this.rank = counter++;
    this.imageURL = json["images"]["medium"];
    this.title = json["title"];
    this.playDate = json["year"];
    this.rating = json["rating"]["average"];
    this.genres = json['genres'].cast<String>();
    this.casts = (json['casts'] as List<dynamic>).map((e) {
      return Actor.fromMap(e);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originalTitle = json["original_title"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'MovieItem{rank: $rank, imageURL: $imageURL, title: $title, playDate: $playDate, rating: $rating, genres: $genres, casts: $casts, director: $director, originalTitle: $originalTitle}';
  }
}