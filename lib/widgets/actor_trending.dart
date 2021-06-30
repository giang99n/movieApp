import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app2/models/item_actor.dart';

Widget buildListActorTrending(
    AsyncSnapshot<Actors> snapshot, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 15,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.results.length,
        itemBuilder: (context, index) {
          return Container(
            height: 80,width: 80,
            child: Card(
              elevation: 3,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                  ),
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${snapshot.data.results[index].profilePath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
