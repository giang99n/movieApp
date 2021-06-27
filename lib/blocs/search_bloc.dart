import 'dart:async';

import 'package:movie_app2/apis/apis.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc{
  final apis = Apis();
  StreamController _searchController = PublishSubject<ItemMovie>();

  Stream<ItemMovie> get searchtream => _searchController.stream;

  void searchMovie(String str) async{
    ItemMovie itemMovieSearch = await apis.fetchMovieSearch(str);
    _searchController.sink.add(itemMovieSearch);
  }

  void dispose(){
    _searchController.close();
  }
}