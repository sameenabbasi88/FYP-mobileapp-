import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lost_and_found_app/CustomAlertBox.dart';

import 'HomeScreen.dart';

class SignUpScreen extends StatelessWidget {
  var username = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();

  signup(BuildContext context,String email,String password) async{
    if(email=='' && password==''){
      CustomAlertBox.customAlertBox(context,'enter required feilds');
    }
    else{
      UserCredential? usercredential;  // ? means it can be null
      try{
        usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password).then((value){
          Navigator.push(context,
              MaterialPageRoute(builder:(context){
                return HomeScreen();
              }));
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
        appBar: AppBar(
          backgroundColor: Color(0xffFFC55A),
          leading: IconButton(
            onPressed: () {},
            icon: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: Color(0xffFFC55A),

            ),
            Positioned(
              top: 120,
              bottom: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      height: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Color(0xff5DEBD7),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 90,
                            ),
                            TextField(
                              controller: email,
                              decoration: InputDecoration(
                                label: Text(
                                  'Email',
                                  style:
                                  Theme.of(context).textTheme.headlineLarge,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(19),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextField(
                              keyboardType: TextInputType.text,
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Text(
                                  'Password',
                                  style:
                                  Theme.of(context).textTheme.headlineLarge,
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
                            SizedBox(height: 90),
                            ElevatedButton(
                              onPressed: () {
                                var emailval = email.text.toString();
                                var passwordval = password.text.toString();
                                signup(context,emailval, passwordval);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(0xff202c6d),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}