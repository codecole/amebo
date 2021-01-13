import 'package:amebo/bloc/bottom_navbar_bloc.dart';
import 'package:amebo/screens/home.dart';
import 'package:amebo/style/theme.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Amèbo',
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: kMainColor,
      ),
      body: SafeArea(
        //this is the stream switching between the Screen containers
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return Home();
              case NavBarItem.SOURCES:
                return Container();
              case NavBarItem.SEARCH:
                return Container();
            }
          },
        ),
      ),
      //the stream handles the styling of the Bottom NavBar
      bottomNavigationBar: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    topLeft: Radius.circular(24.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],
                      spreadRadius: 0,
                      blurRadius: 10.0)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 18.0,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 9.0,
                selectedFontSize: 12.0,
                type: BottomNavigationBarType.fixed,
                fixedColor: kMainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home,size: 24.0,)),
                  BottomNavigationBarItem(
                      label: 'Sources',
                      icon: Icon(Icons.explore_outlined),
                      activeIcon: Icon(Icons.explore_rounded,size: 24.0,)),
                  BottomNavigationBarItem(
                      label: 'Search',
                      icon: Icon(Icons.search_outlined),
                      activeIcon: Icon(Icons.search_rounded,size: 24.0,))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Screen')

        ],
      ),
    );
  }
}
