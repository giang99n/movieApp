import 'package:movie_app2/apis/apis.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final apis = Apis();
  final _moviesRecentlyFetcher = PublishSubject<ItemMovie>();
  final _moviesContinueWatch= PublishSubject<ItemMovie>();

  Stream<ItemMovie> get recentlyAddedMovies => _moviesRecentlyFetcher.stream;
  Stream<ItemMovie> get continueWatchMovie => _moviesContinueWatch.stream;

  fetchAllMovies() async {
    ItemMovie itemMovieRecently = await apis.fetchRecentlyMovie();
    if (!_moviesRecentlyFetcher.isClosed) {
      _moviesRecentlyFetcher.sink.add(itemMovieRecently);
    }
    ItemMovie itemMovieContinueWatch = await apis.fetchContinueWatchMovie();
    if (!_moviesContinueWatch.isClosed) {
      _moviesContinueWatch.sink.add(itemMovieContinueWatch);
    }
  }

  dispose() {
    _moviesRecentlyFetcher.close();
    _moviesContinueWatch.close();
  }
}
