import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(85),
      child: AppBar(
        backgroundColor: Color(0xff202c6d),
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            iconSize: 33,
            onPressed: () {},
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 11),
            width: 240,
            height: 47,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Color(0xffd0d0d0)),
            )),
        actions: [IconButton(
          onPressed: () {},
          icon: IconButton(
            icon: Icon(
              Icons.message_rounded,
              color: Colors.white,
            ),
            iconSize: 33,
            onPressed: () {},
          ),
        ),],

        centerTitle: true,
      ),),



      body: Container(
        color: Color(0xffd0d0d0),
      ),

    );
  }
}
