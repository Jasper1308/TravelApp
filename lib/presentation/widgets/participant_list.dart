import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class ParticipantsListWidget extends StatelessWidget {
  final List<Participant> participants;

  const ParticipantsListWidget({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (participants.isEmpty) {
      return Center(
        child: Text(
          l10n.noParticipantsRegistered,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
    return Wrap(
      spacing: 12.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: participants.map((p) {
        return CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}