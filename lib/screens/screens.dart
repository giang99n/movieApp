export 'home/home_screen.dart';
export 'splash/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:movie_app2/configs/colors.dart';

import 'account/account_screen.dart';
import 'browse/browse_screen.dart';
import 'home/home_screen.dart';

class Screens extends StatefulWidget {

  Screens({Key key}) : super(key: key);
  @override
  _ScreensState createState() => _ScreensState();
}
TabController _tabController;
class _ScreensState extends State<Screens> with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;
  String _title = "Home";
  static const titles = [ "Home", "Browse", "Acount"];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        child: new Scaffold(
          body: switchPage(_selectedIndex),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                text: "Home",
                icon: new Icon(Icons.home),
              ),
              Tab(
                text: "Browse",
                icon: new Icon(Icons.video_settings_rounded),
              ),
              Tab(
                text: "Acount",
                icon: new Icon(Icons.person_outline_rounded),
              ),
            ],
            controller: _tabController,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.bottomBarInactive,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),

    );
  }
  Widget switchPage(int index) {
    switch(index) {
      case 0: return HomeScreen();
      case 1: return BrowseScreen();
      case 2: return AccountScreen();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _title = titles[index];
      _selectedIndex = index;
    });
  }
}
