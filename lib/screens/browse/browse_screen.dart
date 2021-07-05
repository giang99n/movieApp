import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../configs/configs.dart';
import '../../models/models.dart';
import '../../routes.dart';
import '../../widgets/widgets.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  MoviesBloc bloc = new MoviesBloc();
  ActorBloc actorBloc = new ActorBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Browse",
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(color: Color(0xffCED0D2), width: 1),
                      ),
                    ),
                    onPressed: () => AppNavigator.push(Routes.search),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Text(
                              "Search for movie",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
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
                    ModifiedText(
                      text: "Recently Added",
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                    return buildListContinueWatch(snapshot, context);
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
                    ModifiedText(
                      text: "Top Actors",
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                stream: actorBloc.actorsTrending,
                builder: (context, AsyncSnapshot<Actors> snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.hasData) {
                    return buildListActorTrending(snapshot, context);
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
                    ModifiedText(
                      text: "Top Genres",
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
    super.initState();

    bloc.fetchAllMovies();
    actorBloc.fetchActors();
  }

  @override
  void dispose() {
    bloc.dispose();
    actorBloc.dispose();

    super.dispose();
  }
}
