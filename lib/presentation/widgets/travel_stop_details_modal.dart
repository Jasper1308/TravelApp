import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/enums/experience_type.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';
import 'package:travel_app/presentation/widgets/experience_type_selector.dart';

class TravelStopDetailsModal extends StatefulWidget {
  final LatLng? initialPosition;
  final Function(DateTime, DateTime, String, List<ExperienceType>)? addStop;

  const TravelStopDetailsModal({super.key, this.initialPosition, this.addStop});

  @override
  State<TravelStopDetailsModal> createState() => _TravelStopDetailsModalState();
}

class _TravelStopDetailsModalState extends State<TravelStopDetailsModal> {
  DateTime? _arrivalDate;
  DateTime? _departureDate;
  final TextEditingController descriptionController = TextEditingController();
  List<ExperienceType> selectedExperiences = [];

  void addStop(DateTime arrivalDate, DateTime departureDate, String description, List<ExperienceType> experiences){
    if(widget.addStop != null){
      widget.addStop?.call(arrivalDate, departureDate, description, experiences);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DateInputField(
                      label: 'chegada',
                      onDateSelected: (date) {
                        setState(() {
                          _arrivalDate = date;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DateInputField(
                      label: 'saida',
                      onDateSelected: (date) {
                        setState(() {
                          _departureDate = date;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ExperienceTypeSelector(
                selectedExperiences: [],
                onExperiencesSelected: (experiences) {
                  selectedExperiences = experiences;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              ElevatedButton(
                onPressed: () => addStop(_arrivalDate!, _departureDate!, descriptionController.text, selectedExperiences),
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
