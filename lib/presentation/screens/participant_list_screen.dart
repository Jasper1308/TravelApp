import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';

class ParticipantListScreen extends StatelessWidget {
  final int travelId;
  const ParticipantListScreen({super.key, required this.travelId});

  @override
  Widget build(BuildContext context) {
    final participants = context.watch<ParticipantProvider>().participants;

    return Scaffold(
      appBar: AppBar(title: const Text("Selecionar Participante")),
      body: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final p = participants[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: p.photoPath.isNotEmpty ? AssetImage(p.photoPath) : null,
                child: p.photoPath.isEmpty ? const Icon(Icons.person) : null,
              ),
              title: Text(p.name),
              subtitle: Text("Nascimento: ${p.birthdate.toLocal()}"),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  await context.read<ParticipantProvider>().associateWithTravel(p.participantId, travelId);
                  if (context.mounted) Navigator.pop(context, p);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
