import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class TravelMapWidget extends StatelessWidget {
  final List<TravelStop> stops;

  const TravelMapWidget({super.key, required this.stops});

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
        initialCameraPosition: CameraPosition(
          target: LatLng(
            stops.first.coordinates.latitude,
            stops.first.coordinates.longitude,
          ),
          zoom: 12,
        ),
        markers: markers,
        polylines: {polyline},
      ),
    );
  }
}