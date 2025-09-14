import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'participant_register_screen.dart';

class ParticipantPickerScreen extends StatefulWidget {
  const ParticipantPickerScreen({super.key});

  @override
  State<ParticipantPickerScreen> createState() => _ParticipantPickerScreenState();
}

class _ParticipantPickerScreenState extends State<ParticipantPickerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ParticipantProvider>().loadParticipants());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final participants = context.watch<ParticipantProvider>().participants;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectParticipant)),
      body: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final p = participants[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: p.photoPath.isNotEmpty ? FileImage(File(p.photoPath)) : null,
                child: p.photoPath.isEmpty ? const Icon(Icons.person) : null,
              ),
              title: Text(p.name),
              subtitle: Text('${l10n.birthdate}: ${p.birthdate.toLocal().toIso8601String().split('T').first}'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => Navigator.pop(context, p),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const ParticipantRegisterScreen()));
          await context.read<ParticipantProvider>().loadParticipants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
