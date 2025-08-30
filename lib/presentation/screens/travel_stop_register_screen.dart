import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/presentation/widgets/map_picker.dart';
import 'package:travel_app/presentation/widgets/travel_stop_details_modal.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/andress_formatter.dart';

class TravelStopRegisterScreen extends StatefulWidget {
  final TravelStop? stop;

  const TravelStopRegisterScreen({
    super.key,
    this.stop,
  });

  @override
  State<TravelStopRegisterScreen> createState() =>
      _TravelStopRegisterScreenState();
}

class _TravelStopRegisterScreenState extends State<TravelStopRegisterScreen> {
  late LatLng _cordinates;


  void _showStopDetailsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TravelStopDetailsModal(
          initialPosition: _cordinates,
          addStop: (arrivalDate, departureDate, description, experiences) {
            final travelState = Provider.of<TravelState>(
              context,
              listen: false,
            );

            travelState.addStop(
              TravelStop(
                travelStopId: 0,
                stopOrder: travelState.travels.length + 1,
                placeName: 'null',
                cordinates: _cordinates,
                arrivalDate: arrivalDate,
                departureDate: departureDate,
                lenghtStay: arrivalDate.difference(departureDate),
                experiences: experiences,
                description: description,
              ),
            );
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MapScreen(
              onMapTap: (coordinates) {
                setState(() {
                  _cordinates = coordinates;
                });
                _showStopDetailsModal();
              },
            ),
          ),
        ],
      ),
    );
  }
}
