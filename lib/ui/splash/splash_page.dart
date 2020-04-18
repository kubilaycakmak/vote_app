import 'package:flutter/material.dart';
import 'package:vote_app/ui/splash/splash.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/welcome/welcome_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new WelcomePage(),
      title: new Text('VOTE',
        style: titleText
      ),
      gradientBackground: backgroundGradient,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loadingText: Text('Loading', style: paragraphText,),
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}