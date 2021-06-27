import 'package:flutter/material.dart';
import 'package:movie_app2/blocs/search_bloc.dart';
import 'package:movie_app2/models/item_movie.dart';
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
    _searchController=TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      height:45,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          TextField(
                                autofocus: true,
                                controller: _searchController,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (str){
                                  searchBloc.searchMovie(str);
                                },
                                style: TextStyle(fontSize: 16,color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: "Search",
                                    prefixIcon: Container(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                              ),
                          Positioned(
                              right:0,top: 0,height: 45,width: 50,
                              child: InkWell(
                                child: Icon(Icons.close),
                                onTap: () {
                                  _searchController.text="";
                                }
                              )
                          ),
                        ],
                      ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: modified_text(text: "Search Results", fontWeight: FontWeight.bold, size: 18, color: Colors.black,),
                  ),
                  Container(
                    height: 550,
                    child: StreamBuilder(
                      stream: searchBloc.searchtream,
                      builder: (context, AsyncSnapshot<ItemMovie> snapshot) {
                        if (snapshot.hasData) {
                          print("sssssssssss");
                          return buildListMoiveSearch(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Text(snapshot.error.toString());
                      },
                    ),
                  ),
                ],
              ),
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
          return  GestureDetector(
            onTap: () {},
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
                      padding: const EdgeInsets.fromLTRB(0,0,15,0),
                      child: ClipRRect(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                            height: 160,
                            fit:BoxFit.fill
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
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
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
                          Text("Action",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black54, fontSize: 14,),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,size: 18,
                              ),
                            ],
                          ),
                          Container(
                            width: 160,
                            child: Text(snapshot.data.results[index].overview,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(fontSize: 14, color: Colors.black54),

                            ),
                          )

                        ],
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
