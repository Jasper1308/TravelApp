import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/presentation/widgets/location_search_bar.dart';
import 'package:travel_app/services/location_service.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng)? onMapTap;

  const MapScreen({super.key, this.onMapTap});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentLocation;
  GoogleMapController? _googleMapController;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      Position position = await LocationService.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _currentLocation = position;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao obter localização: \$e')));
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
    widget.onMapTap?.call(position);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _currentLocation!.latitude,
                _currentLocation!.longitude,
              ),
              zoom: 15,
            ),
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (controller) {
              _googleMapController = controller;
            },
            onTap: _onMapTap,
            markers: {
              if (_selectedLocation != null)
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: _selectedLocation!,
                ),
            },
          ),
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: LocationSearchBar(
              onPlaceSelected: (position) {
                _googleMapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 15,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  _currentLocation!.latitude,
                  _currentLocation!.longitude,
                ),
                zoom: 15,
              ),
            ),
          );
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
