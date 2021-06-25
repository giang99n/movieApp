import 'dart:async';

class SearchBloc{
  StreamController _searchController = new StreamController();

  Stream get searchtream => _searchController.stream;


  void dispose(){
    _searchController.close();
  }
}