import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../apis/apis.dart';
import '../../models/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailEventStated) {
      yield* _mapMovieEventStartedToState(event.id);
    }
  }

  Stream<MovieDetailState> _mapMovieEventStartedToState(int id) async* {
    final apiRepository = Apis();
    yield MovieDetailLoading();
    try {
      final movieDetail = await apiRepository.getMovieDetail(id);
      print(movieDetail.toString() + "bloc");
      yield MovieDetailLoaded(movieDetail);
    } on Exception catch (e) {
      print(e);
      yield MovieDetailError();
    }
  }
}
