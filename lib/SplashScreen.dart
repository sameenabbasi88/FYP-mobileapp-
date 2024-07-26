import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/WelcomeScreen.dart';
import 'package:lost_and_found_app/main.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, SecondaryAnimation) =>
                  WelcomeScreen(),
              transitionsBuilder:
                  (context, animation, SecondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInToLinear;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 200)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xffFFC55A), Color(0xff5DEBD7) ],
        begin: FractionalOffset(1.0, 0.0),
        end: FractionalOffset(0.0, 13.0),

        // Color(0xff, yai must dena hoga iskai agai color likhna hoga)
      )),
      child: Center(
        child: TypewriterAnimatedTextKit(
          isRepeatingAnimation: false,
          speed: Duration(
            milliseconds: 40,
          ),
          text: [
            'Lost  &  Found Pakistan',
          ],
          textStyle: TextStyle(
              fontFamily: 'FontMain',
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
