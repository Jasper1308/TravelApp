import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/enums/experience_type.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/widgets/experience_type_selector.dart';

class TravelStopDetailsModal extends StatefulWidget {
  final LatLng? initialPosition;
  final DateTime? arrivalDate;
  final DateTime? departureDate;
  final Function(int, String, List<ExperienceType>)? addStop;

  const TravelStopDetailsModal({
    super.key,
    this.initialPosition,
    this.arrivalDate,
    this.departureDate,
    this.addStop,
  });

  @override
  State<TravelStopDetailsModal> createState() => _TravelStopDetailsModalState();
}

class _TravelStopDetailsModalState extends State<TravelStopDetailsModal> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController lengthStayController = TextEditingController();
  final ValueNotifier<List<ExperienceType>> selectedExperiencesNotifier =
  ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    lengthStayController.addListener(_onLengthChanged);
  }

  void _onLengthChanged() {
    setState(() {});
  }

  void addStop(
      int lengthStay,
      String description,
      List<ExperienceType> experiences,
      ) {
    if (widget.addStop != null) {
      widget.addStop?.call(lengthStay, description, experiences);
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    lengthStayController.dispose();
    selectedExperiencesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAddButtonEnabled = lengthStayController.text.isNotEmpty;
    final l10n = AppLocalizations.of(context)!;

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
              if (widget.arrivalDate != null || widget.departureDate != null)
                Row(
                  children: [
                    if (widget.arrivalDate != null)
                      Text(
                        '${l10n.arrival}: ${widget.arrivalDate!.toLocal().toIso8601String().split('T').first}',
                      ),
                    const SizedBox(width: 12),
                    if (widget.departureDate != null)
                      Text(
                        '${l10n.departure}: ${widget.departureDate!.toLocal().toIso8601String().split('T').first}',
                      ),
                  ],
                ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: lengthStayController,
                decoration: InputDecoration(
                  labelText: l10n.durationInDays,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              ExperienceTypeSelector(
                selectedExperiences: [],
                onExperiencesSelected: (experiences) {
                  selectedExperiencesNotifier.value = experiences;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.description,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isAddButtonEnabled
                    ? () { addStop(
                  int.tryParse(lengthStayController.text) ?? 0,
                  descriptionController.text,
                  selectedExperiencesNotifier.value,
                );
                Navigator.pop(context);
                lengthStayController.clear();
                descriptionController.clear();
                selectedExperiencesNotifier.value = [];
                }
                    : null,
                child: Text(l10n.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}