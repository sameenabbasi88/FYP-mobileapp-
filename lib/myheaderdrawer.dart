import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found_app/imagepicker.dart';


class myheaderdrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> Myheaderdrawer();
}
class Myheaderdrawer extends State<myheaderdrawer> {

  File? selectedImage;
  final _auth=FirebaseAuth.instance;
  late User loggedInuser;
  String? currentUser = '';
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != Null) {
        loggedInuser = user!;
        currentUser = loggedInuser.email;
        print(loggedInuser.email);
        print(currentUser);
      }
    }
    catch (e) {
      print(e);
    }
  }
  Future<void> pickImageFromGallery() async {
    final galleryImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (galleryImage != null) {
      setState(() {
        selectedImage = File(galleryImage.path);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  Widget build(BuildContext context) {
   return Container(
     color: Color(0xff5DEBD7),
     width: double.infinity,
     height: 300,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         InkWell(
           onTap: () async {
          await pickImageFromGallery();

           },
             child: Icon(Icons.account_circle,size: 90,color: Colors.black)),
         Text('User',
           style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),),
       ],
     ),
   );
  }
}
