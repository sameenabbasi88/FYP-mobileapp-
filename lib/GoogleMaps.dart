import 'dart:io'; // Use dart:io for File handling
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'PostEditScreen_L.dart'; // Ensure this path is correct

void main() {
  runApp(MaterialApp(
    home: MapScreen(selectedImages: []), // Pass an empty list or your actual images here
  ));
}

class MapScreen extends StatefulWidget {
  final List<File> selectedImages;
  MapScreen({required this.selectedImages});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
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
  }
}
