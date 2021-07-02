import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app2/blocs/search_bloc.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:movie_app2/screens/detail/detail_screen.dart';
import 'package:movie_app2/screens/home/home_screen.dart';
import 'package:movie_app2/utils/utils.dart';
import 'package:movie_app2/widgets/continue_watch.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc searchBloc = new SearchBloc();
  var _searchController;

  @override
  void dispose() {
    searchBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      TextField(
                        autofocus: true,
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (str) {
                          searchBloc.searchMovie(str);
                        },
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Search",
                            prefixIcon: Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffCED0D2),
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    25)))),
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          height: 45,
                          width: 50,
                          child: InkWell(
                              child: Icon(Icons.close),
                              onTap: () {
                                _searchController.text = "";
                              }
                          )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: modified_text(text: "Search Results",
                    fontWeight: FontWeight.bold,
                    size: 18,
                    color: Colors.black,),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: searchBloc.searchtream,
                    builder: (context, AsyncSnapshot<ItemMovie> snapshot) {
                      if (snapshot.hasData) {
                        print("sssssssssss");
                        return buildListMoiveSearch(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Center();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }

  Widget buildListMoiveSearch(AsyncSnapshot<ItemMovie> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movieId: snapshot.data.results[index].id),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: ClipRRect(
                      child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w185${snapshot.data
                              .results[index].poster_path}',
                          height: 160,
                          fit: BoxFit.fill,
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              snapshot.data.results[index].title,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating:  double.parse(snapshot.data.results[index].vote_average )/ 2,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 14,
                                direction: Axis.horizontal,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child:
                                Text((  double.parse(snapshot.data.results[index].vote_average )/ 2).toString()),
                              ),
                            ],
                          ),
                          Text(snapshot.data.results[index].vote_count.toString() + " Ratings",style: TextStyle(fontSize: 12)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(snapshot.data.results[index].overview,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),

                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
