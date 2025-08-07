import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/widgets/map_picker.dart';
import 'package:travel_app/presentation/widgets/travel_stop_details_modal.dart';
import 'package:travel_app/providers/travel_provider.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopRegisterScreen extends StatefulWidget {
  const TravelStopRegisterScreen({super.key});

  @override
  State<TravelStopRegisterScreen> createState() =>
      _TravelStopRegisterScreenState();
}

class _TravelStopRegisterScreenState extends State<TravelStopRegisterScreen> {
  final TextEditingController _placeController = TextEditingController();
  late final LatLng _cordinates;
  DateTime? _arrivalDate;
  DateTime? _departureDate;
  List<ExperienceType> selectedExperiences = [];

  void _showStopDetailsModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TravelStopDetailsModal(selectedCordinates: _cordinates);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Parada'), centerTitle: true),
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
