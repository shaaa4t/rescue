import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqwa/component/rounded_button.dart';
import 'package:tqwa/component/trapezoid_down_cut.dart';
import 'package:tqwa/home.dart';
import 'package:tqwa/utility/app_constant.dart';

class SignInTab extends StatefulWidget {
  final Function onPressed;

  SignInTab({@required this.onPressed});

  @override
  _SignInTabState createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    return (await _auth.signInWithEmailAndPassword(
            email: userNameController.text, password: passwordController.text))
        .user;
  }

  String type;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.0,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.width * 0.05),
      child: Stack(
        children: <Widget>[
          TrapezoidDownCut(
            child: Stack(
              children: <Widget>[
                Material(
                  elevation: 16,
                  child: Container(
                      height: double.infinity,
                      color: Colors.white,
                      child: _buildForm(size, textTheme, context)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 12,
            child: InkWell(
              onTap: widget.onPressed,
              child: Material(
                  elevation: 0.0,
                  color: Color(0xffEC5A7A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm(Size size, TextTheme textTheme, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: size.height * 0.02, left: 24, right: 24),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Center(child: Image.asset(IMAGE_LOGO_PATH)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: _buildTextFormEmail(textTheme),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: _buildTextFormPassword(textTheme),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text('Select Type'),
                    value: type,
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('Police'),
                        value: 'police',
                      ),
                      DropdownMenuItem(
                        child: Text('Fire'),
                        value: 'fire',
                      ),
                      DropdownMenuItem(
                        child: Text('Ambulance'),
                        value: 'ambulance',
                      ),
                      DropdownMenuItem(
                        child: Text('Savage'),
                        value: 'savage',
                      ),
                    ],
                    dropdownColor: Colors.teal,
                    onChanged: (item) {
                      setState(() {
                        type = item;
                      });
                    }),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.05),
                child: Container(
                  width: 200,
                  child: RoundedButton(
                    text: BUTTON_LOGIN,
                    onPressed: () async {
                      startSignIn();
                    },
                    linearGradient: LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
//                            Color(getColorHexFromStr("#FE685F")),
//                            Color(getColorHexFromStr("#FB578B")),
                        Color(0xff3DD0BD),
                        Color(0xff3DD0BD)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  startSignIn() async {
    showDialog(
        context: context,
        builder: (_) => Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
    try {
      final user = await _handleSignIn();
      print('User Data -----> ');
      print('ID : ' + user.uid);
      print('Email : ' + user.email);
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      sharedPreferences.setString("type", type);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(type: type),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('error!'),
                content: Text(
                  '$e',
                  style: TextStyle(color: Colors.red),
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Done'))
                ],
              ));
    }
  }

  Widget _buildTextFormEmail(TextTheme textTheme) {
    return TextField(
      decoration: new InputDecoration(
        hintText: EMAIL_AUTH_HINT,
        suffixIcon: Icon(
          Icons.email,
          color: Colors.grey[200],
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: userNameController,
    );
  }

  Widget _buildTextFormPassword(TextTheme textTheme) {
    return TextField(
      decoration: new InputDecoration(
          hintText: PASSWORD_AUTH_HINT,
          suffixIcon: Icon(Icons.lock, color: Colors.grey[200])),
      keyboardType: TextInputType.text,
      controller: passwordController,
      obscureText: true,
    );
  }
}
