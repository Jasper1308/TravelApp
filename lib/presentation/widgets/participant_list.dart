import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({super.key});

  @override
  Widget build(BuildContext context) {
    final participants = context.watch<ParticipantProvider>().participants;

    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final p in participants)
              CircleAvatar(
                backgroundImage: p.photoPath.isNotEmpty ? FileImage(File(p.photoPath)) : null,
                child: p.photoPath.isEmpty ? Text(p.name.isNotEmpty ? p.name[0] : '?') : null,
              ),
          ],
        ),
        const SizedBox(height: 12),
        RegisterButton(
          onPressed: () => Navigator.pushNamed(context, '/participant-register'),
          text: 'Cadastrar Participante',
        ),
      ],
    );
  }
}
