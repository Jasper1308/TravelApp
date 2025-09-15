import 'dart:io';

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
      spacing: 8,
      runSpacing: 8,
      children: participants.map((p) {
        return CircleAvatar(
          radius: 24,
          backgroundImage: p.photoPath.isNotEmpty ? FileImage(File(p.photoPath)) : null,
          child: p.photoPath.isEmpty ? Text(p.name.isNotEmpty ? p.name[0] : '?') : null,
        );
      }).toList(),
    );
  }
}