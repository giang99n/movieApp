import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/item_movie.dart';
import '../routes.dart';

Widget buildListRecentlyAdded(
    AsyncSnapshot<ItemMovie> snapshot, BuildContext context) {
  return CarouselSlider.builder(
    itemCount: snapshot.data.results.length,
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 1.1 / 4,
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
        onTap: () =>
            AppNavigator.push(Routes.detail, snapshot.data.results[index].id),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].backdrop_path}',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 3 / 4,
                height: MediaQuery.of(context).size.height / 4,
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/img_not_found.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
