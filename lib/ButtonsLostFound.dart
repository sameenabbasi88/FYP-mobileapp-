// button screen, either lost item or found item
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found_app/PostEditScreen_L.dart';
import 'package:lost_and_found_app/PostEditScreen_F.dart';
class addImages extends StatefulWidget {
  @override
  State<addImages> createState() => _Addimages();
}

class _Addimages extends State<addImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5DEBD7),
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
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
      body: Container(
        color: Color(0xffFFC55A),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 60,
              margin: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostEditScreen(selectedImages: [],  location: LatLng(30.3753, 69.3451),)));
                },
                child: Text('Lost Items',style: TextStyle(fontSize: 20,color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xff5DEBD7),
                ),
              ),
            ),
            Container(
              width: 250,
              height: 60,
              margin: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostEditScreenF(selectedImages: [], location: LatLng(30.3753, 69.3451),)));
                  print("Gone to Found Screen");

                },
                child: Text('Found Items',style: TextStyle(fontSize: 20,color: Colors.black),),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: addImages(),
  ));
}
