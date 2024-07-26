//(buttons to pick images from gallery/camera)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'PostEditScreen_L.dart';
import 'PostEditScreen_F.dart';
class ImagePickerScreen extends StatefulWidget {
  final String? status;
  // Constructor with required parameter
  ImagePickerScreen({this.status});
  @override
  State<ImagePickerScreen> createState() => ImagePickerScreenState(stat: status);
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  List<File> selectedImages = [];
  String? stat;
  ImagePickerScreenState({this.stat});
  Future<void> pickImageFromGallery() async {
    final List<XFile> galleryImages = await ImagePicker().pickMultiImage();

    if (galleryImages != null && galleryImages.isNotEmpty) {
      setState(() {
        for (int i = 0; i < galleryImages.length; i++) {
          selectedImages.add(File(galleryImages[i].path));}
      });
      sendimage();
    }
  }

  Future<void> pickImageFromCamera() async {
    final cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (cameraImage != null) {
      setState(() {
        selectedImages.add(File(cameraImage.path));
      });
    }
  }
  ShowAlertBox(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title:  Text('pick image from'),
        content: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('camera'),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('gallery'),
            ),
          ],
        ),
      );
    });
  }
  sendimage (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => stat=='lost' ? PostEditScreen(selectedImages: selectedImages, location: LatLng(30.3753, 69.3451),): PostEditScreenF(selectedImages: selectedImages, location: LatLng(30.3753, 69.3451),),
      ),
    );
  }

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
      body: Container(
        width: double.infinity,
        color: Color(0xffd0d0d0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              child: Text('From Gallery',style: TextStyle(fontSize: 20,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color(0xff202c6d),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromCamera();
              },
              child: Text('From Camera',style: TextStyle(fontSize: 20,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color(0xff202c6d),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

