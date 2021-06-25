import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app2/apis/rest_client.dart';
import 'package:movie_app2/configs/configs.dart';
import 'package:movie_app2/blocs/movie_bloc.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app2/utils/utils.dart';
Widget buildListContinueWatch(AsyncSnapshot<ItemMovie> snapshot) {
  return  SingleChildScrollView(
    child: CarouselSlider.builder(
      itemCount: snapshot.data.results.length,
      options: CarouselOptions(
        height: 300,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        viewportFraction: 0.45,
        enlargeCenterPage: false,
      ),
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,15,0),
                child: ClipRRect(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                      fit: BoxFit.cover,
                    ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                child: Text(
                    snapshot.data.results[index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  overflow: TextOverflow.ellipsis,
                  ),
              ),
            ],
          ),
        );
      },
    ),
  );
}