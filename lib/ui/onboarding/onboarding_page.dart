import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqwa/ui/onboarding/onboarding_animation.dart';
import 'package:tqwa/ui/onboarding/tabs/signin_tab.dart';
import 'package:tqwa/ui/onboarding/tabs/signup_tab.dart';
import 'package:tqwa/utility/app_constant.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController animationController;
  OnBoardingEnterAnimation onBoardingEnterAnimation;
  ValueNotifier<double> selectedIndex = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    onBoardingEnterAnimation = OnBoardingEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildContent());

  Widget _buildContent() {
    final Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: <Widget>[
              _buildTopBubble(
                  size.height,
                  -size.height * 0.5,
                  -size.width * 0.1,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
//                  Color(getColorHexFromStr("#EA9F57")),
//                  Color(getColorHexFromStr("#DD6F85")),
                      Color(0xff3DD0BD),
                      Color(0xff3DD0BD)
                    ],
                  )),
              _buildTopBubble(
                  size.width,
                  -size.width * 0.5,
                  size.width * 0.5,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.2),
                    ],
                  )),
              _buildTopBubble(
                  size.width,
                  -size.width * 0.5,
                  -size.width * 0.7,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.2),
                    ],
                  )),
              _buildTopBubble(
                  size.width,
                  -size.width * 0.7,
                  -size.width * 0.4,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.2),
                    ],
                  )),
              _buildTopBubble(
                  size.width,
                  -size.width * 0.7,
                  size.width * 0.2,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.2),
                    ],
                  )),
              _buildTopBubble(
                  size.width * 0.5,
                  -size.width * 0.5,
                  size.width * 0.5,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[Color(0xff3DD0BD), Color(0xff3DD0BD)],
                  )),
              _buildTopBubble(
                  size.height * 0.5,
                  size.height * 0.5,
                  -size.width * 0.5,
                  LinearGradient(
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    colors: <Color>[
//                  Color(getColorHexFromStr("#EC5A7A")),
//                  Color(getColorHexFromStr("#E17D73")),
                      Color(0xffEC5A7A),
                      Color(0xffE17D73)
                    ],
                  )),
              FadeTransition(
                opacity: onBoardingEnterAnimation.fadeTranslation,
                child: NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    if (notification.depth == 0 &&
                        notification is ScrollUpdateNotification) {
                      selectedIndex.value = _pageController.page;
                      setState(() {});
                    }
                    return false;
                  },
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    physics: new NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {},
                    children: <Widget>[
                      SignInTab(
                        onPressed: () {
                          // sign up & in data handling
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        },
                      ),
                      SignUpTab(onPressed: () {
                        _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildTopBubble(double diameter, double top, double right,
      LinearGradient linearGradient) {
    return Positioned(
      top: top,
      right: right,
      child: Transform(
        transform: Matrix4.diagonal3Values(
            onBoardingEnterAnimation.scaleTranslation.value,
            onBoardingEnterAnimation.scaleTranslation.value,
            0.0),
        child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(diameter / 2),
                gradient: linearGradient)),
      ),
    );
  }
}
