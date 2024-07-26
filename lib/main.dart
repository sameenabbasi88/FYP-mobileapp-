import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:const FirebaseOptions(
      apiKey: 'AIzaSyAr58XLAdpDMgA1yYM982uvBBeZm2t6ElY',
      appId: '1:230668107856:android:0d52ea373f558ed4239155',
      messagingSenderId: '230668107856',
      storageBucket: "gs://lostandfoundapp-c6bd1.appspot.com",
      projectId: 'lostandfoundapp-c6bd1'),);
  // You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
  }
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  })
      .onError((err) {
    // Error getting token.
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
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
              headlineLarge: TextStyle(fontFamily:'MainFont',fontSize: 20,color: Colors.black),//for textfields
              headlineMedium: TextStyle(fontFamily:'MainFont',fontSize: 50,fontWeight: FontWeight.bold,color: Colors.black),//for headings
            headlineSmall: TextStyle(fontFamily:'MainFont',fontSize: 25,fontWeight: FontWeight.w100,color: Colors.black),
          ),
      ),
      home:Splashscreen()
    );
  }
}


