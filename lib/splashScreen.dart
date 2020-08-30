import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqwa/home.dart';
import 'package:tqwa/ui/onboarding/onboarding_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkLogin() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String type = sharedPreferences.getString("type")??"fire";
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => Home(
                    type: type,
                  )),
          ModalRoute.withName('/'));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => OnboardingPage()),
          ModalRoute.withName('/'));
    }
  }
}
