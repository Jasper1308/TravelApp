import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';

class ParticipantRegisterScreen extends StatefulWidget {
  const ParticipantRegisterScreen({super.key});

  @override
  State<ParticipantRegisterScreen> createState() => _S();
}

class _S extends State<ParticipantRegisterScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Participante')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: _image == null ? null : FileImage(_image!),
                ),
              ),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe nome' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  if (_birth == null || _image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos campos')),
                    );
                    return;
                  }
                  final participant = Participant(
                    participantId: 0,
                    name: _nameCtrl.text,
                    birthdate: _birth!,
                    photoPath: _image!.path,
                  );
                  await context.read<ParticipantProvider>().addParticipant(participant);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
