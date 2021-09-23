import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/bloc/movie/movie_state.dart';
import 'package:testing/services/services.dart';
import 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  //initial State
  MovieBloc() : super(MovieStateInitial());
  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetchedEvent &&
        !(state is MovieStateSuccess &&
            (state as MovieStateSuccess).hasReachedEnd)) {
      try {
        //Check if "has reached end of a page"
        if (state is MovieStateInitial) {
          //first time loading page
          //1.get comments from API
          //2.yield CommentStateSuccess
          final movies = await getMoviesFromApi();
          yield MovieStateSuccess(movies: movies, hasReachedEnd: false);
        }
      } catch (exception) {
        yield MovieStateFailure();
      }
    }
  }
}
