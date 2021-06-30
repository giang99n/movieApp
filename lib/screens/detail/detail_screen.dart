import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app2/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie_app2/blocs/movie_detail_bloc/movie_detail_event.dart';
import 'package:movie_app2/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:movie_app2/models/movie_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(MovieDetailEventStated(movieId)),
      child: WillPopScope(
        child: Scaffold(
          body: BuildDetailBody(),
        ),
        onWillPop: () async => true,
      ),
    );
  }

}


class BuildDetailBody extends StatefulWidget {
  @override
  _BuildDetailBodyState createState() => _BuildDetailBodyState();
}

class _BuildDetailBodyState extends State<BuildDetailBody> with SingleTickerProviderStateMixin{
    TabController _tabController;
    MovieDetail movieDetail;


    @override
    void initState(){
      _tabController = new TabController(length: 4, vsync: this);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
      return BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoading) {
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
          );
        } else if (state is MovieDetailLoaded) {
          movieDetail = state.detail;

          String genres = "";
          for (int i = 0; i < movieDetail.genres.length; i++) {
            if (i == movieDetail.genres.length - 1) {
              genres = genres + movieDetail.genres[i].name.toString();
            } else
              genres = genres + movieDetail.genres[i].name.toString() + ", ";
          }
          ;

          return Stack(
            children: [
              ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath.toString()}',
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(

                      child: Platform.isAndroid
                          ? CircularProgressIndicator()
                          : CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/img_not_found.jpg'),
                        ),
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () async {
                        final youtubeUrl =
                            'https://www.youtube.com/embed/${movieDetail.trailerId}';
                        if (await canLaunch(youtubeUrl)) {
                          print(youtubeUrl);
                          for (int i = 0; i < movieDetail.genres.length; i++) {
                            print(movieDetail.genres[i].name);
                          }
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                          child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.grey,
                        size: 95,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            movieDetail.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Colors.black),
                          ),
                        ),
                        Text(
                          genres,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black54),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: movieDetail.voteAverage / 2,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child:
                                  Text((movieDetail.voteAverage / 2).toString()),
                            ),
                          ],
                        ),
                        Text(movieDetail.voteCount.toString() + " Ratings"),
                        SizedBox(height: 20,),
                        Container(
                          height:MediaQuery.of(context).size.height / 3 ,
                          width: double.infinity,
                          child: Column(
                            children: [
                              TabBar(
                                unselectedLabelColor: Colors.black54,
                                labelColor: Colors.red,
                                tabs: [
                                  Tab(
                                    child: Text("Info", style: TextStyle(fontSize: 15),),
                                  ),
                                  Tab(
                                    child: Text("Reviews", style: TextStyle(fontSize: 15),),
                                  ),
                                  Tab(
                                    child: Text("Photos", style: TextStyle(fontSize: 15),),
                                  ),
                                  Tab(
                                    child: Text("Video", style: TextStyle(fontSize: 15),
                                    ),
                                  ),

                                ],
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                   _info(context),
                                    _reviews(context),
                                    _photos(context),
                                    _video(context),
                                  ],
                                  controller: _tabController,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                left: 10,
                height: 50,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)),),
                        backgroundColor: Colors.red
                      ),
                  child: Text("Watch movie",style: TextStyle(fontSize: 16,color: Colors.white),),),
              ),

            ],
          );
        } else {
          return Container();
        }
      });


  }
    Widget _info(BuildContext context) {
     return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          child: Text(
            "Overview: "+ movieDetail.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }
    Widget _reviews(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          child: Text(
            "Overview: "+ movieDetail.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }
    Widget _photos(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          child: Text(
            "Overview: "+ movieDetail.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }
    Widget _video(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          child: Text(
            "Overview: "+ movieDetail.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }
    


}


