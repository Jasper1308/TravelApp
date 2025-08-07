import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng)? onMapTap;
  const MapScreen({super.key, this.onMapTap});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _initialCameraPosition = CameraPosition(
    target: LatLng(-26.9, -48.6),
    zoom: 12,
  );
  GoogleMapController? _googleMapController;
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: (controller) {
                  _googleMapController = controller;
                },
                onTap: widget.onMapTap,
                markers: {
                  if (_selectedLocation != null)
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: _selectedLocation!,
                    ),
                },
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          );
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
