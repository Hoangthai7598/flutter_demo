import 'dart:convert';
import 'package:testing/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/comment.dart';

Future<List<Comment>> getCommentsFromApi(int start, int limit) async {
  final url = Uri.parse(
      "https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit");
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      final List<Comment> comments = responseData.map((comment) {
        return Comment(
            id: comment['id'],
            name: comment['name'],
            email: comment['email'],
            body: comment['body']);
      }).toList();
      return comments;
    } else {
      return <Comment>[];
    }
  } catch (exception) {
    print('Exception sending api : ' + exception.toString());
    return <Comment>[];
  }
}

Future<List<Movie>> getMoviesFromApi() async {
  final url =
      Uri.parse("https://www.omdbapi.com/?s=Batman&page=1&apikey=564727fa");
  final http.Client httpClient = http.Client();
  print('a');
  try {
    final response = await httpClient.get(url);
    print(response);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Iterable movies = responseData['Search'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      return <Movie>[];
    }
  } catch (exception) {
    print('Exception sending api : ' + exception.toString());
    return <Movie>[];
  }
}
