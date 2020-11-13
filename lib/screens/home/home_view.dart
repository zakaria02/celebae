import 'package:flutter/material.dart';
import 'double_take/main_view.dart';
import 'likes/main_view.dart';
import 'messages/main_view.dart';
import 'profile/main_view.dart';

class Home extends StatefulWidget {
  // Widget child;
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  final Color primaryColor = Color(0xFFff0e55);
  final List<Widget> _children = [
    DoubleTakeView(),
    LikesView(),
    MessagesView(),
    ProfileView(),
  ];
  double height = 0, width = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.art_track,
            ),
            title: new Text(
              'DoubleTake',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.favorite,
            ),
            title: new Text(
              'Likes',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.mail,
            ),
            title: new Text(
              'Messages',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ))
        ],
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: primaryColor,
        showUnselectedLabels: true,
      ),
      body: _children[_currentIndex],
    );
  }
}
