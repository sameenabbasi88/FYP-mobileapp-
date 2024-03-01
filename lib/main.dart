import 'package:flutter/material.dart';
import 'package:lost_and_found_app/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost And Found App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff202c6d)),
        useMaterial3: true,
          textTheme: TextTheme(
              headlineLarge: TextStyle(fontSize: 20,color: Color(0xff202c6d)),
              headlineMedium: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)
          ),
      ),
      home:Splashscreen()
    );
  }
}


