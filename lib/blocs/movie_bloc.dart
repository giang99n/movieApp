import 'package:movie_app2/apis/apis.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
final apis = Apis();
final _moviesFetcher = PublishSubject<ItemMovie>();

Stream<ItemMovie> get allMovies => _moviesFetcher.stream;

fetchAllMovies() async {
  ItemMovie itemMovie = await apis.fetchAllMovie();
  if (!_moviesFetcher.isClosed) {
    _moviesFetcher.sink.add(itemMovie);
  }

}

dispose() {
  _moviesFetcher.close();
}
}

final bloc = MoviesBloc();