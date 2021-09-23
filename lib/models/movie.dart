class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String type;
  final String poster;

  Movie(
      {required this.imdbID,
      required this.title,
      required this.year,
      required this.type,
      required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        imdbID: json['imdbID'],
        poster: json['Poster'],
        title: json['Title'],
        year: json['Year'],
        type: json['Type']);
  }
}
