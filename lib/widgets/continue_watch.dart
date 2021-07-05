import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/item_movie.dart';
import '../routes.dart';

Widget buildListContinueWatch(
    AsyncSnapshot<ItemMovie> snapshot, BuildContext context) {
  return SingleChildScrollView(
    child: CarouselSlider.builder(
      itemCount: snapshot.data.results.length,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 1.1 / 3,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        viewportFraction: 0.45,
        enlargeCenterPage: false,
      ),
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return Wrap(
          children: [
            GestureDetector(
              onTap: () => AppNavigator.push(
                  Routes.detail, snapshot.data.results[index].id),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/img_not_found.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RatingBarIndicator(
                          rating: double.parse(
                                  snapshot.data.results[index].vote_average) /
                              2,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                          direction: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          (double.parse(snapshot
                                      .data.results[index].vote_average) /
                                  2)
                              .toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
