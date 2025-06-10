import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:learning_mgt/Utils/Geolocation.dart';

class MapLocationPicker extends StatefulWidget {
  @override
  _MapLocationPickerState createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  GoogleMapController? _controller;
  LatLng? _selectedPosition;

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
      fetchPincode(position.latitude,position.longitude);
    });
    print("Selected Lat: ${position.latitude}, Lng: ${position.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(28.6139, 77.2090), // New Delhi by default
              zoom: 12,
            ),
            onMapCreated: (controller) => _controller = controller,
            onTap: _onMapTapped,
            markers: _selectedPosition != null
                ? {
                    Marker(
                      markerId: MarkerId("selected"),
                      position: _selectedPosition!,
                    ),
                  }
                : {},
          ),
          if (_selectedPosition != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Lat: ${_selectedPosition!.latitude}, Lng: ${_selectedPosition!.longitude}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
