// post screen like instagram
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class PostScreen extends StatefulWidget {
  late final List<File> selectedImages;
  final String textval;


  PostScreen({required this.selectedImages, required this.textval});
  @override
  State<PostScreen> createState() => post();
}

class post extends State<PostScreen> {

  final CarouselController carouselController=CarouselController();
  int currentIndex=0;
  var arr=[
    {'name':'User1', 'msg-unread':'3'},
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Container(
        width: double.infinity,
        color: Color(0xffd0d0d0),
        child: ListView(
          children: arr.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> value = entry.value;

            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: // ...

                    CarouselSlider(
                      items: widget.selectedImages.map((imageFile) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 10, // Adjust the top position as needed
                                  right: 10, // Adjust the left position as needed
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    radius: 20,
                                    child: Text(
                                      "${widget.selectedImages.indexOf(imageFile) + 1} / ${widget.selectedImages.length}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),

// ...

                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(value['name'].toString()),
                        subtitle: Text(widget.textval),
                        trailing: Icon(Icons.message_rounded,size: 35,color: Color(0xff202c6d),)
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PostScreen(selectedImages: [], textval: '',),
  ));
}
