
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lost_and_found_app/HomeScreen.dart';

import 'CustomAlertBox.dart';

class LoginScreen extends StatelessWidget {
  var email = TextEditingController();

  var password = TextEditingController();

  login(BuildContext context,String email,String password) async{
    if(email=='' && password==''){
      CustomAlertBox.customAlertBox(context,'enter required feilds');
    }
    else{
      UserCredential? usercredential;  // ? means it can be null
      try{
        usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value){
              Navigator.push(context as BuildContext,
              MaterialPageRoute(builder:(context){
                return HomeScreen();
              }
              ));
        });
      }
      on FirebaseAuthException catch(ex){
        return CustomAlertBox.customAlertBox(
            context as BuildContext,ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffFFC55A),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Text(
                  "Login ",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 90),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Color(0xff202c6d),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(height: 80),
                SizedBox(
                  height: 50,
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      var emailval = email.text.toString();
                      var passwordval = password.text.toString();
                      login(context,emailval, passwordval);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xff5DEBD7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 680,
          right: 260,
          child: Container(
            width: 250,
            height: 350,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff5DEBD7)),
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 15),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
