import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app2/apis/rest_client.dart';
import 'package:movie_app2/configs/configs.dart';
import 'package:movie_app2/blocs/movie_bloc.dart';
import 'package:movie_app2/models/item_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app2/screens/search/searchScreen.dart';
import 'package:movie_app2/utils/utils.dart';
import 'package:movie_app2/widgets/continue_watch.dart';
import 'package:movie_app2/widgets/recently_added.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Home Screen'),
//       ),
//     );
//   }
// }
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MoviesBloc bloc =new MoviesBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Movie",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: CircleAvatar(
                        backgroundImage: AssetImage(AppAssets.cat)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      side: BorderSide(color: Color(0xffCED0D2), width: 1),
                    ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          SizedBox(height:40,
                              width:40,child: Center(child: Icon(Icons.search,color: Colors.black,),)),
                          Padding(
                            padding: const EdgeInsets.only(left: 40,right: 40),
                            child: Text("Search for movie",style: TextStyle(fontSize: 16,color: Colors.grey),),
                          )
                        ],
                      ),
                    ),
                ),
              ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    modified_text(text:"Recently Added",size: 16,fontWeight: FontWeight.bold, color: Colors.black,),
                    InkWell(
                      child: Text(
                        "See all",
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: bloc.recentlyAddedMovies,
                builder: (context, AsyncSnapshot<ItemMovie> snapshot) {
                  if (snapshot.hasData) {
                    return buildListRecentlyAdded(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    modified_text(text:"Continue Watch...",size: 16,fontWeight: FontWeight.bold, color: Colors.black,),
                    InkWell(
                      child: Text(
                        "See all",
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: bloc.continueWatchMovie,
                builder: (context, AsyncSnapshot<ItemMovie> snapshot) {
                  if (snapshot.hasData) {
                    return buildListContinueWatch(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    modified_text(text:"Trending",size: 16,fontWeight: FontWeight.bold, color: Colors.black,),
                    InkWell(
                      child: Text(
                        "See all",
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();

  }


}
