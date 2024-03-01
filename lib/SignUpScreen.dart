import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatelessWidget {
  var username = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff202c6d),
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
              color: Color(0xff202c6d),
            ),
            Positioned(
              top: 140,
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
                      height: 90,
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      height: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Color(0xffd0d0d0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            TextField(
                              controller: username,
                              decoration: InputDecoration(
                                label: Text(
                                  'User Name',
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
                            SizedBox(height: 50),
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
                                var usernameval = username.text.toString();
                                var emailval = email.text.toString();
                                var passwordval = password.text.toString();
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
