import 'package:flutter/material.dart';
import 'package:tqwa/home.dart';
import 'package:tqwa/ui/onboarding/onboarding_page.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(0xff3DD0BD),
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/travel.jpeg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tqwa El Turki',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        ' tqwa2@gmail.com',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          buildListTile(Icons.home, 'Home', null, context),
          buildListTile(Icons.person_outline, 'Profile', null, context),
          buildListTile(
              Icons.notifications_none,
              'Notification',
              () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  ),
              context),
          buildListTile(Icons.info, 'About Program', null, context),
          buildListTile(
              Icons.exit_to_app,
              'Logout',
              () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OnboardingPage(),
                    ),
                  ),
              context),
        ],
      ),
    );
  }

  Widget buildListTile(
          IconData icon, String title, Function ontap, BuildContext context) =>
      GestureDetector(
        onTap: ontap, //Navigate to page
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      );
}
