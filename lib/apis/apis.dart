import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app2/apis/rest_client.dart';
import 'package:movie_app2/configs/constants.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:movie_app2/models/movie_detail.dart';

class Apis{
  final movieApi= MovieApiProvider();

  Future<ItemMovie> fetchRecentlyMovie()=> movieApi.getListRecentlyMovie();
  Future<ItemMovie> fetchContinueWatchMovie()=> movieApi.getListContinueWatchMovie();
  Future<ItemMovie> fetchMovieSearch(String str)=> movieApi.getListMovieSearch(str);
  Future<MovieDetail> getMovieDetail(int id)=> movieApi.getMovieDetail(id);
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

  Future<ItemMovie> getListMovieSearch(String str) async{
    Response response;
    try {
      response = await restClient.get('search/movie',queryParameters: {'api_key': AppConstants.apiKey,'query':str});
      if (response.statusCode == 200) {
        return ItemMovie.fromJson(response.data);
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }

  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    Response response;
    try {
      response = await restClient.get('movie/$movieId',queryParameters: {'api_key': AppConstants.apiKey});
      if (response.statusCode == 200) {
        MovieDetail movieDetail = MovieDetail.fromJson(response.data);
        movieDetail.trailerId= await getYoutubeId(movieId);
        return movieDetail;
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }
  Future<String> getYoutubeId(int movieId) async {
    try {
      final response = await restClient.get('/movie/$movieId/videos',queryParameters: {'api_key': AppConstants.apiKey});
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}

