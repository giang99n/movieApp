import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app2/apis/rest_client.dart';
import 'package:movie_app2/configs/configs.dart';
import 'package:movie_app2/blocs/movie_bloc.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app2/screens/detail/detail_screen.dart';
import 'package:movie_app2/utils/utils.dart';
Widget buildListRecentlyAdded(AsyncSnapshot<ItemMovie> snapshot) {
  return  CarouselSlider.builder(
    itemCount: snapshot.data.results.length,
    options: CarouselOptions(
      enableInfiniteScroll: true,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      pauseAutoPlayOnTouch: true,
      viewportFraction: 0.8,
      enlargeCenterPage: true,
    ),
    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movieId: snapshot.data.results[index].id),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            ClipRRect(
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].backdrop_path}',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 15,
                left: 15,
              ),
              child: Text(
                snapshot.data.results[index].title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}