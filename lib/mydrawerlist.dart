import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/LoginScreen.dart';

class mydrawerlist extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> Mydrawerlist();
}
class Mydrawerlist extends State<mydrawerlist> {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      margin: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Home',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:Color(0xff202c6d))),
          SizedBox(height: 30,),
          Text('Youraccount',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Color(0xff202c6d))),
          SizedBox(height: 30,),
          Text('About app',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Color(0xff202c6d))),
          SizedBox(height: 30,),
          GestureDetector(onTap: (){
            _auth.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
              child: Text('Logout',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Color(0xff202c6d)))),
        ],
      ),
    );
  }
}
