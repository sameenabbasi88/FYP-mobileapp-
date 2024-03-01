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
  var arr=[
    {'name':'User1', 'number':"03815646382", 'msg-unread':'3'},
    {'name':'User2', 'number':"03815646382", 'msg-unread':'2'},
    {'name':'User3', 'number':"03815646382", 'msg-unread':'1'},
    {'name':'User4', 'number':"03815646382", 'msg-unread':'5'}

  ];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('flutter container'),

        ),
        body: Container(
          child: ListView(
              children: arr.map((value) {
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(value['name'].toString()),
                  subtitle: Text(value['number'].toString()),
                  trailing: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green,
                      child: Text(value['msg-unread'].toString())),
                );
              } ).toList()
          ),
        )
    );
  }
}









