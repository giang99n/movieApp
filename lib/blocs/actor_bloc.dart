import 'dart:async';

import 'package:movie_app2/apis/apis.dart';
import 'package:movie_app2/models/item_actor.dart';
import 'package:rxdart/rxdart.dart';

class ActorBloc{
  final apis = Apis();
  StreamController _actorController = PublishSubject<Actors>();

  Stream<Actors> get actorsTrending => _actorController.stream;

  void fetchActors() async{
    Actors actors = await apis.getListTrendingActor();
    _actorController.sink.add(actors);
  }

  void dispose(){
    _actorController.close();
  }
}