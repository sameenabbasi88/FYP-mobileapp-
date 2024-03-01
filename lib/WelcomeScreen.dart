import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lost_and_found_app/LoginScreen.dart';
import 'package:lost_and_found_app/SignUpScreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 60.0),
      width: double.infinity,
      height: double.infinity,
      color: Color(0xffd0d0d0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(
              'assets/images/Welcomepg.png',
              width: 150,
            ),
            SizedBox(
              height: 90,
            ),
            Text(
              'Lost  &  Found Pakistan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 125),
            Container(
              height: 55,
              width: 260,
              margin: EdgeInsets.only(top: 60.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }));
                },
                child: Text(
                  "Let's  get  started",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xff202c6d),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '     I already have an account   ',
                  style: TextStyle(fontSize: 22),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Icon(
                    Icons.arrow_circle_right,
                    size: 40,
                    color: Color(0xff202c6d),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
