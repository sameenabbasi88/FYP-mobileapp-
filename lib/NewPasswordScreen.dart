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

        body:Container(
          padding: EdgeInsets.all(12.0),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffd0d0d0),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text("New Password ",style:Theme.of(context).textTheme.headlineMedium,),
              SizedBox(height: 90),
              TextField(
                decoration: InputDecoration(
                  label: Text('New Password',
                    style: Theme.of(context).textTheme.headlineLarge,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                      borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye,color:Color(0xff202c6d),),
                    onPressed: (){},
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  label: Text('Re-Enter Password',style: Theme.of(context).textTheme.headlineLarge,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                      borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye,color:Color(0xff202c6d),),
                    onPressed: (){},
                  ),
                ),
              ),

              SizedBox(height: 130),
              SizedBox(
                height: 50,
                width: 190,
                child: ElevatedButton(onPressed: (){},
                  child: Text("Confirm",
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff202c6d),
                  ),),
              ),
            ],
          ),
        )
    );
  }
}
