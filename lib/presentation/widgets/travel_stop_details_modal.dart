import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';

class TravelStopDetailsModal extends StatefulWidget {
  final LatLng selectedCordinates;

  const TravelStopDetailsModal({super.key, required this.selectedCordinates});

  @override
  State<TravelStopDetailsModal> createState() => _TravelStopDetailsModalState();
}

class _TravelStopDetailsModalState extends State<TravelStopDetailsModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                DateInputField(label: 'chegada', onDateSelected: (date) {}),
                DateInputField(label: 'saida', onDateSelected: (date) {}),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Adicionar')),
          ],
        ),
      ),
    );
  }
}
