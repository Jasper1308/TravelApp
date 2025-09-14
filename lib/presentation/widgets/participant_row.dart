import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/participant.dart';

class ParticipantRow extends StatelessWidget {
  final List<Participant> participants;

  const ParticipantRow({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
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
