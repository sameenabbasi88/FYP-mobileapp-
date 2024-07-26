import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found_app/GoogleMaps.dart';
import 'package:lost_and_found_app/HomeScreen.dart';
import 'package:lost_and_found_app/PostScreen.dart';
import 'package:lost_and_found_app/imagepicker.dart';
import 'package:provider/provider.dart';

import 'NewPostListener.dart';

class PostEditScreen extends StatefulWidget {
  final List<File> selectedImages;
  final LatLng location;

  PostEditScreen({required this.selectedImages, required this.location});

  @override
  _PostEditScreenState createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final TextEditingController textBox = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController locController = TextEditingController();
  String selectedCategory = 'General Item';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String? currentUser = '';

  Future<void> _pickLocation() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(selectedImages: []),
      ),
    );

    if (result != null) {
      setState(() {
        locController.text = 'Lat: ${result.latitude}, Lng: ${result.longitude}';
      });
    } else {
      setState(() {
        locController.text = 'nothing selected';
      });
    }
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        currentUser = loggedInUser.email;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    Firebase.initializeApp().then((value) {
      print("Firebase initialized successfully");
    }).catchError((error) {
      print("Failed to initialize Firebase: $error");
    });
  }

  Future<void> _uploadDataToFirebase() async {
    List<String> imageUrls = [];
    try {
      for (File imageFile in widget.selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
        await storageReference.putFile(imageFile);
        String downloadURL = await storageReference.getDownloadURL();
        imageUrls.add(downloadURL);
      }

      await FirebaseFirestore.instance.collection('posts').add({
        'images': imageUrls,
        'description': textBox.text,
        'category': selectedCategory,
        'city': cityController.text,
        //'location': locController.text,
        'status': 'lost',
        'email': currentUser,
      }
      );
      NewFoundPostListener().startListening();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (error) {
      print('Error uploading data to Firebase: $error');
    }
  }

  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  final LatLng _initialPosition = LatLng(30.3753, 69.3451); // Center of Pakistan

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _showAddressBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 5.0,
                  ),
                  onTap: _onTap,
                  markers: _selectedLocation != null
                      ? {
                    Marker(
                      markerId: MarkerId('selected-location'),
                      position: _selectedLocation!,
                    ),
                  }
                      : {},
                ),
              ),
              if (_selectedLocation != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selected Location: (${_selectedLocation!.latitude}, ${_selectedLocation!.longitude})',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ElevatedButton(
                onPressed: _selectedLocation != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostEditScreen(
                        location: _selectedLocation!,
                        selectedImages: widget.selectedImages,
                      ),
                    ),
                  );
                }
                    : null,
                child: Text('Confirm Location'),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5DEBD7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffFFC55A),
        padding: EdgeInsets.all(7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: widget.selectedImages.map((file) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      file,
                      width: 100,
                      height: 100,
                    ),
                  );
                }).toList(),
              ),
              InkWell(
                onTap: () async {
                  List<File> newImages = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePickerScreen(status: 'lost'),
                    ),
                  );

                  if (newImages != null && newImages.isNotEmpty) {
                    setState(() {
                      widget.selectedImages.addAll(newImages);
                    });
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Color(0xff5DEBD7),
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                maxLines: 3,
                controller: textBox,
                decoration: InputDecoration(
                  hintText: 'Add description here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: <String>['General Item', 'Person', 'Pet']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  hintText: 'City',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              /*TextField(
                controller: locController,
                decoration: InputDecoration(
                  hintText: 'Add address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: Theme.of(context).textTheme.headlineLarge,
                readOnly: true,
                onTap: _showAddressBottomSheet,
              ),
              SizedBox(height: 20),*/
              ElevatedButton(
                onPressed: _uploadDataToFirebase,
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor:Color(0xff5DEBD7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
