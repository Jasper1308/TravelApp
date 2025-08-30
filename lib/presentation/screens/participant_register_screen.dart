import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';

class ParticipantRegister extends StatefulWidget {
  const ParticipantRegister({super.key});

  @override
  State<ParticipantRegister> createState() => _ParticipantRegisterState();
}

class _ParticipantRegisterState extends State<ParticipantRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _birthdate;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final participantState = Provider.of<ParticipantState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de participantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  radius: 50,
                  child: _imageFile == null ? Icon(Icons.camera_alt) : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                }
              ),
              const SizedBox(height: 20),
              DateInputField(
                  label: 'Data de nascimento',
                  onDateSelected: (date) {
                    _birthdate = date;
                  }
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final participant = Participant(
                        participantId: 0,
                        name: _nameController.text,
                        birthdate: _birthdate!,
                        photoPath: _imageFile!.path,
                      );
                      participantState.addParticipant(participant);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Cadastrar')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
