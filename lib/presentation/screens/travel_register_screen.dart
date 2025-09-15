import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/providers/travel_stop_provider.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/presentation/screens/participant_picker_screen.dart';
import 'package:travel_app/presentation/screens/participant_register_screen.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';
import 'package:travel_app/presentation/widgets/participant_list.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';
import 'package:travel_app/presentation/widgets/stop_list.dart';

class TravelRegisterScreen extends StatelessWidget {
  const TravelRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final register = context.watch<TravelRegisterProvider>();
    final stops = context.watch<TravelStopProvider>().stops;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.registerTrip)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                initialValue: register.name,
                decoration: InputDecoration(labelText: l10n.tripName),
                onChanged: (v) => context.read<TravelRegisterProvider>().setBasic(name: v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TransportType>(
                value: register.transport,
                decoration: InputDecoration(labelText: l10n.transport),
                items: TransportType.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                    .toList(),
                onChanged: (t) => context.read<TravelRegisterProvider>().setBasic(transportType: t),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DateInputField(
                      label: l10n.start,
                      onDateSelected: (d) => context.read<TravelRegisterProvider>().setBasic(start: d),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateInputField(
                      label: l10n.end,
                      onDateSelected: (d) => context.read<TravelRegisterProvider>().setBasic(end: d),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const StopList(),
              const SizedBox(height: 16),
              Text(l10n.participants, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              ParticipantsListWidget(participants: register.participants),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.person_add),
                      label: Text(l10n.addParticipant),
                      onPressed: () async {
                        await context.read<ParticipantProvider>().loadParticipants();
                        final p = await Navigator.push<Participant?>(
                          context,
                          MaterialPageRoute(builder: (_) => const ParticipantPickerScreen()),
                        );
                        if (p != null) context.read<TravelRegisterProvider>().toggleParticipant(p);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person),
                    label: Text(l10n.registerParticipant),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ParticipantRegisterScreen()),
                      );
                      await context.read<ParticipantProvider>().loadParticipants();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RegisterButton(
                onPressed: () async {
                  try {
                    final id = await context.read<TravelRegisterProvider>().save(stopsToSave: stops);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.tripCreated(id))));
                      context.read<TravelStopProvider>().clearStops();
                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                text: l10n.saveTrip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
