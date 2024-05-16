import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: const Duration(milliseconds: 600*5),
        splashTransition: SplashTransition.fadeTransition,
        splash: Image.asset('assets/images/splash/splash.png'  ),
        nextRoute: initialRoute(),
        nextScreen: const Text('Splash Screen'),
        splashIconSize: 200,
        centered: true,
        duration: 3000,


    );
  }

}


