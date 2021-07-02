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
          print("loading");
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
          );
        } else if (state is MovieDetailLoaded) {
          movieDetail = state.detail;
          print( state.detail.toString()+"saaaaaaaaaaaaa");
          String genres = "";
          for (int i = 0; i < movieDetail.genres.length; i++) {
            if (i == movieDetail.genres.length - 1) {
              genres = genres + movieDetail.genres[i].name.toString();
            } else
              genres = genres + movieDetail.genres[i].name.toString() + ", ";
          }

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
              ),Positioned(
                top: 5,left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          final youtubeUrl =
                              'https://www.youtube.com/embed/${movieDetail.trailerId}';
                          if (await canLaunch(youtubeUrl)) {
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
                  ),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
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
                                    child: Text("Photos", style: TextStyle(fontSize: 15),maxLines: 1,),
                                  ),
                                  Tab(
                                    child: Text("Reviews", style: TextStyle(fontSize: 15),  overflow: TextOverflow.ellipsis,maxLines: 1,),
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
                                    _photos(context),
                                    _reviews(context),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22)),),
                        backgroundColor: Colors.red
                      ),
                  child: Text("Watch movie",style: TextStyle(fontSize: 16,color: Colors.white),),
                  onPressed: () async {
                    final youtubeUrl =
                        'https://www.youtube.com/embed/${movieDetail.trailerId}';
                    if (await canLaunch(youtubeUrl)) {
                      await launch(youtubeUrl);
                    }
                  },
                ),
              ),

            ],
          );
        } else {
          return Container();
        }
      });


  }
    Widget _info(BuildContext context) {
     return SingleChildScrollView(
       child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15,10,10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RUNTIME: ",
                        style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50,),
                      Text(
                        movieDetail.runtime.toString()+"mins",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15,10,10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Storyline",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                      ),
                      Text(
                         movieDetail.overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
     );
    }

    Widget _photos(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          height: 155,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: movieDetail.productionCompanies.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 3/4,
                child: Card(
                  elevation: 3,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator(),
                      ),
                      imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.productionCompanies[index].logoPath}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
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


