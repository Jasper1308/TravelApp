import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class TravelMapWidget extends StatelessWidget {
  final List<TravelStop> stops;
  final Function(GoogleMapController)? onMapCreated;
  final Function(LatLngBounds)? onMapRendered;

  const TravelMapWidget({
    super.key,
    required this.stops,
    this.onMapCreated,
    this.onMapRendered,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (stops.isEmpty) {
      return Center(child: Text(l10n.noStopsRegistered));
    }

    final markers = stops.map((s) {
      final coords = s.coordinates;
      return Marker(
        markerId: MarkerId(s.travelStopId.toString()),
        position: LatLng(coords.latitude, coords.longitude),
        infoWindow: InfoWindow(
          title: s.placeName,
          snippet: s.description,
        ),
      );
    }).toSet();

    final polyline = Polyline(
      polylineId: const PolylineId("rota"),
      color: Colors.blue,
      width: 4,
      points: stops.map((s) {
        final coords = s.coordinates;
        return LatLng(coords.latitude, coords.longitude);
      }).toList(),
    );

    return SizedBox(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: _calculateInitialCameraPosition(),
        markers: markers,
        polylines: {polyline},
        onMapCreated: (controller) {
          onMapCreated?.call(controller);
          controller.animateCamera(
            CameraUpdate.newLatLngBounds(_calculateBounds(), 50),
          ).then((_) {
            onMapRendered?.call(_calculateBounds());
          });
        },
      ),
    );
  }

  CameraPosition _calculateInitialCameraPosition() {
    if (stops.isEmpty) {
      return const CameraPosition(target: LatLng(0, 0), zoom: 12);
    }
    final centerLat = stops.map((s) => s.coordinates.latitude).reduce((a, b) => a + b) / stops.length;
    final centerLng = stops.map((s) => s.coordinates.longitude).reduce((a, b) => a + b) / stops.length;
    return CameraPosition(
      target: LatLng(centerLat, centerLng),
      zoom: 12,
    );
  }

  LatLngBounds _calculateBounds() {
    if (stops.isEmpty) {
      return LatLngBounds(
        northeast: const LatLng(0, 0),
        southwest: const LatLng(0, 0),
      );
    }
    double minLat = stops.first.coordinates.latitude;
    double maxLat = stops.first.coordinates.latitude;
    double minLng = stops.first.coordinates.longitude;
    double maxLng = stops.first.coordinates.longitude;

    for (var stop in stops) {
      minLat = min(minLat, stop.coordinates.latitude);
      maxLat = max(maxLat, stop.coordinates.latitude);
      minLng = min(minLng, stop.coordinates.longitude);
      maxLng = max(maxLng, stop.coordinates.longitude);
    }

    return LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
  }
}