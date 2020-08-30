import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tqwa/component/rounded_button.dart';
import 'package:tqwa/component/trapezoid_up_cut.dart';
import 'package:tqwa/home.dart';
import 'package:tqwa/utility/app_constant.dart';

class SignUpTab extends StatefulWidget {
  final Function onPressed;

  SignUpTab({@required this.onPressed});

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.0,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.width * 0.0),
      child: Stack(
        children: <Widget>[
          TrapezoidUpCut(
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
            top: 24,
            left: 12,
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
                      'SIGN IN',
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
        padding: EdgeInsets.only(top: size.height * 0.15, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Image.asset(IMAGE_LOGO_PATH),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: _buildTextFormUsername(textTheme),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: _buildTextFormPassword(
                    textTheme, PASSWORD_AUTH_HINT, passwordController),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: _buildTextFormPassword(
                    textTheme, CONFIRM_AUTH_HINT, confirmController),
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.05),
                  child: Container(
                    width: 200,
                    child: RoundedButton(
                      text: BUTTON_SIGNUP,
                      onPressed: () {
                        stratSingUp();
                      },
                      linearGradient: LinearGradient(
                        begin: FractionalOffset.bottomLeft,
                        end: FractionalOffset.topRight,
                        colors: <Color>[Color(0xff3DD0BD), Color(0xff3DD0BD)],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildTextFormUsername(TextTheme textTheme) {
    return TextField(
      decoration: new InputDecoration(
        hintText: EMAIL_AUTH_HINT,
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey[200],
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: userNameController,
    );
  }

  Widget _buildTextFormPassword(
      TextTheme textTheme, String hint, TextEditingController co) {
    return TextField(
      decoration: new InputDecoration(
          hintText: hint,
          fillColor: Colors.grey[200],
          suffixIcon: Icon(Icons.lock, color: Colors.grey[200])),
      keyboardType: TextInputType.text,
      controller: co,
      obscureText: true,
    );
  }

  void stratSingUp() async {
    try {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: userNameController.text,
        password: passwordController.text,
      ))
          .user;
      Navigator.of(context).pop();
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Done'),
            content: Text(
              "Go to sign in page ",
              style: TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Go'))
            ],
          ));

    } catch (e) {
      Navigator.of(context).pop();
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('error'),
                content: Text(
                  "$e",
                  style: TextStyle(color: Colors.red),
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('موافق'))
                ],
              ));
      return;
    }
  }
}
