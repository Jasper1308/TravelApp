import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/providers/travel_stop_provider.dart';
import 'package:travel_app/presentation/widgets/map_screen.dart';
import 'package:travel_app/presentation/widgets/travel_stop_details_modal.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/address_formatter.dart';

class TravelStopRegisterScreen extends StatefulWidget {
  const TravelStopRegisterScreen({super.key});
  @override
  State<TravelStopRegisterScreen> createState() => _State();
}

class _State extends State<TravelStopRegisterScreen> {
  LatLng? _coords;
  String? _placeName;

  Future<void> _onMapTap(LatLng coords) async {
    setState(() {
      _coords = coords;
      _placeName = null;
    });

    try {
      final r = await NominatimService.reverseGeocode(coords);
      if (!mounted) return;
      setState(() => _placeName = r.address != null ? formatStopAddress(r.address!) : null);
      if (_placeName != null) {
        _showModal();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao buscar o local: $e')));
    }
  }

  void _showModal() {
    if (_coords == null) return;
    final travelProvider = context.read<TravelRegisterProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TravelStopDetailsModal(
          initialPosition: _coords!,
          arrivalDate: travelProvider.initialDate,
          departureDate: travelProvider.endDate,
          addStop: (lengthStay, description, experiences) async {
            if (_coords == null || _placeName == null) return;
            await context.read<TravelStopProvider>().addStop(
              coordinates: _coords!,
              description: description,
              placeName: _placeName!,
              lengthStay: lengthStay,
              experiences: experiences,
              arrivalDate: travelProvider.initialDate ?? DateTime.now(),
              departureDate: travelProvider.endDate ?? DateTime.now(),
            );
            if (context.mounted) Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapScreen(onMapTap: _onMapTap),
      ],
    );
  }
}