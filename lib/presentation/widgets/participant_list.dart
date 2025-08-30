import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';

class ParticipantList extends StatefulWidget {
  const ParticipantList({super.key});

  @override
  State<ParticipantList> createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  @override
  Widget build(BuildContext context) {
    final participantState = Provider.of<ParticipantState>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            if (participantState.participants.isNotEmpty)
              ...participantState.participants.map(
                    (participant) => CircleAvatar(
                  backgroundImage: FileImage(
                    File(participant.photoPath),
                  ),
                ),
              ),
          ],
        ),
        RegisterButton(
          onPressed: () => Navigator.pushNamed(
            context,
            '/participant-register',
          ),
          text: 'Cadastrar Participante',
        ),
      ],
    );
  }
}
