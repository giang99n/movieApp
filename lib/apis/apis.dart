import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app2/apis/rest_client.dart';
import 'package:movie_app2/configs/constants.dart';
import 'package:movie_app2/models/item_model.dart';
import 'package:movie_app2/models/item_movie.dart';

class Apis{
  final movieApi= MovieApiProvider();

  Future<ItemMovie> fetchRecentlyMovie()=> movieApi.getListRecentlyMovie();
  Future<ItemMovie> fetchContinueWatchMovie()=> movieApi.getListContinueWatchMovie();

}

class MovieApiProvider{
  RestClient restClient=RestClient(Dio());
  Future<ItemMovie> getListRecentlyMovie() async{
    Response response;
    try {
      response = await restClient.get('movie/popular',queryParameters: {'api_key': AppConstants.apiKey});
      if (response.statusCode == 200) {
        return ItemMovie.fromJson(response.data);
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

//  RestClient restClient=RestClient(Dio());
  Future<ItemMovie> getListContinueWatchMovie() async{
    Response response;
    try {
      response = await restClient.get('movie/now_playing',queryParameters: {'api_key': AppConstants.apiKey});
      if (response.statusCode == 200) {
        return ItemMovie.fromJson(response.data);
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }


}
// class ContinueWatchMovieApiProvider{
//   RestClient restClient=RestClient(Dio());
//   Future<ItemMovie> getListContinueWatchMovie() async{
//     Response response;
//     try {
//       response = await restClient.get('movie/now_playing',queryParameters: {'api_key': AppConstants.apiKey});
//       if (response.statusCode == 200) {
//         return ItemMovie.fromJson(response.data);
//       } else {
//         print("There is some problem status code not 200");
//       }
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }

