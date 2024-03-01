import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  var email = TextEditingController();

  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffd0d0d0),
          ),
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
              Container(
                  padding: EdgeInsets.all(13.0),
                  margin: EdgeInsets.only(left: 200),
                  child: Text(
                    'forget password?',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 190,
                child: ElevatedButton(
                  onPressed: () {
                    var emailval = email.text.toString();
                    var passwordval = password.text.toString();
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff202c6d),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 680,
          right: 260,
          child: Container(
            width: 250,
            height: 350,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff202c6d)),
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 15),
              child: IconButton(
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
        ),
      ],
    ));
  }
}
