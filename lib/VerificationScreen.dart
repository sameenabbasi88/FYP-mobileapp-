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

        body: Container(
          color: Color(0xffd0d0d0),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70),
                Text("Verification ",style:Theme.of(context).textTheme.headlineMedium,),
                SizedBox(height: 50),
                Image.asset('assets/images/ForgetPassword.png',height: 190,),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: double.infinity,
                  height: 100,
            
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: 80,
                        height: 90,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(19),
                                borderSide: BorderSide.none
                            ),
                              contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: 80,
                        height: 90,
            
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(19),
                                borderSide: BorderSide.none
                            ),
                              contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: 80,
                        height: 90,
            
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(19),
                                borderSide: BorderSide.none
                            ),
                              contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: 80,
                        height: 90,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(19),
                                borderSide: BorderSide.none
                            ),
                              contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
            
                    ],
                  ),
                ),
                SizedBox(height: 270),
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
        )
    );
  }
}
