import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final index;
  BottomBar({this.index = 2});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      onTap: (i) {
        if (i == 3) {
          Navigator.pushNamed(context, '/cate');
        }
      },
      currentIndex: widget.index,
      selectedItemColor: Colors.purple,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          title: Text('PROFILE'),
          backgroundColor: Color(0xff3DD0BD),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notifications'),
          backgroundColor: Color(0xff3DD0BD),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('HOME'),
          backgroundColor: Color(0xff3DD0BD),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('Categories'),
          backgroundColor: Color(0xff3DD0BD),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
          backgroundColor: Color(0xff3DD0BD),
        ),
      ],
    );
  }
}
