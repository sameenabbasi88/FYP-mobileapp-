import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,

          textTheme: TextTheme(
              headlineLarge: TextStyle(fontSize: 20,color: Color(0xff202c6d)),
              headlineMedium: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)
          )
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:Stack(
          children: [

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffd0d0d0),),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text("Forget Password ",style:Theme.of(context).textTheme.headlineMedium,),
                    SizedBox(height: 85),
                    Image.asset('assets/images/ForgetPassword.png',height: 190,),
                    SizedBox(height: 80),
                    TextField(
                      decoration: InputDecoration(
                        label: Text('Email',style: Theme.of(context).textTheme.headlineLarge,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(19),
                            borderSide: BorderSide.none
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text('Please write your email to recieve '
                          'a confirmation code to set a new password',textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),),
                    ),
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ElevatedButton(onPressed: (){},
                        child: Text("Next",
                          style: TextStyle(fontSize: 20,color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color(0xff202c6d),
                        ),),
                    ),
                  ],
                ),
              ),
            ),
           

          ],
        )
    );
  }
}
