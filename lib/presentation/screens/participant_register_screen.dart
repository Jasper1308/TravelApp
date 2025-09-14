import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';

class ParticipantRegisterScreen extends StatefulWidget {
  const ParticipantRegisterScreen({super.key});

  @override
  State<ParticipantRegisterScreen> createState() => _ParticipantRegisterScreenState();
}

class _ParticipantRegisterScreenState extends State<ParticipantRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  DateTime? _birth;
  File? _image;

  Future<void> pickImage() async {
    final p = ImagePicker();
    final f = await p.pickImage(source: ImageSource.gallery);
    if (f != null) setState(() => _image = File(f.path));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.registerParticipant)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(radius: 40, backgroundImage: _image == null ? null : FileImage(_image!)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: l10n.name),
                validator: (v) => v == null || v.isEmpty ? l10n.requiredName : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (d != null) setState(() => _birth = d);
                      },
                      child: Text(_birth == null ? l10n.birthdate : _birth!.toLocal().toIso8601String().split('T').first),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  if (_birth == null || _image == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.fillAllFields)));
                    }
                    return;
                  }
                  final participant = Participant(
                    participantId: 0,
                    name: _nameCtrl.text.trim(),
                    birthdate: _birth!,
                    photoPath: _image!.path,
                  );
                  await context.read<ParticipantProvider>().addParticipant(participant);
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(l10n.register),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
