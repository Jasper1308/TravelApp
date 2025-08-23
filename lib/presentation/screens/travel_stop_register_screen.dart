import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/presentation/widgets/map_picker.dart';
import 'package:travel_app/presentation/widgets/travel_stop_details_modal.dart';
import 'package:travel_app/providers/travel_provider.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopRegisterScreen extends StatefulWidget {
  final LatLng? initialPosition;
  final Function()? addStop;

  const TravelStopRegisterScreen({
    super.key,
    this.initialPosition,
    this.addStop,
  });

  @override
  State<TravelStopRegisterScreen> createState() =>
      _TravelStopRegisterScreenState();
}

class _TravelStopRegisterScreenState extends State<TravelStopRegisterScreen> {
  late final LatLng _cordinates;
  DateTime? _arrivalDate;
  DateTime? _departureDate;
  List<ExperienceType> selectedExperiences = [];

  void _showStopDetailsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TravelStopDetailsModal(
          initialPosition: _cordinates,
          addStop: () {
            final travelState = Provider.of<TravelState>(
              context,
              listen: false,
            );

            travelState.addStop(
              TravelStop(
                travelStopId: 0,
                stopOrder: travelState.travels.length + 1,
                placeName: 'a',
                cordinates: _cordinates,
                arrivalDate: _arrivalDate!,
                departureDate: _departureDate!,
                lenghtStay: Duration(minutes: 10),
                experiences: selectedExperiences,
                description: 'a',
              ),
            );
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
