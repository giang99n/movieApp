import 'package:flutter/material.dart';
import 'package:movie_app2/blocs/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   SearchBloc searchBloc = new SearchBloc();
  TextEditingController _searchController = new TextEditingController();
  @override
  void dispose() {
    searchBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height:45,
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Positioned(
                            right:0,top: 0,
                            child: Center(
                              child: TextButton(
                                onPressed: (){_searchController.text="";},
                                child: Icon(Icons.highlight_remove_rounded,color: Colors.black,size: 30,),
                              ),
                            )
                        ),
                        StreamBuilder<Object>(
                          stream: searchBloc.searchtream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (str){
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
                            );
                          }
                        ),

                      ],
                    ),
                  ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
