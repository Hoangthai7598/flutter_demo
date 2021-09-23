import 'package:equatable/equatable.dart';
import 'package:testing/models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieStateInitial extends MovieState {}

class MovieStateFailure extends MovieState {}

class MovieStateSuccess extends MovieState {
  final List<Movie> movies;
  final bool hasReachedEnd;

  const MovieStateSuccess({required this.movies, required this.hasReachedEnd});

  @override
  // TODO: implement props
  List<Object> get props => [movies, hasReachedEnd];
  MovieStateSuccess cloneWith({List<Movie>? movies, bool? hasReachedEnd}) {
    return MovieStateSuccess(
        movies: movies ?? this.movies,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}
