import 'dart:async';

import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../account/account_screen.dart';
import '../browse/browse_screen.dart';
import '../home/home_screen.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key key}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> _screens = [
    HomeScreen(),
    BrowseScreen(),
    AccountScreen(),
  ];

  TabController _tabController;
  PageController _pageController;
  StreamController<int> _indexController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _pageController = PageController();
    _indexController = StreamController<int>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => _indexController.add(index),
        children: _screens,
      ),
      bottomNavigationBar: StreamBuilder<int>(
        initialData: 0,
        stream: _indexController.stream,
        builder: (context, snapshots) {
          final int cIndex = snapshots.data;
          return TabBar(
            tabs: [
              Tab(
                text: "Home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "Browse",
                icon: Icon(Icons.video_settings_rounded),
              ),
              Tab(
                text: "Acount",
                icon: Icon(Icons.person_outline_rounded),
              ),
            ],
            controller: _tabController,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.bottomBarInactive,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            onTap: (index) {
              if (index != cIndex) {
                _indexController.add(index);
                _pageController.jumpToPage(index);
              }
            },
          );
        },
      ),
    );
  }
}
