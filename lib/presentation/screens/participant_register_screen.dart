import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/controllers/participant_provider.dart';

class ParticipantRegister extends StatefulWidget {
  const ParticipantRegister({super.key});

  @override
  State<ParticipantRegister> createState() => _ParticipantRegisterState();
}

class _ParticipantRegisterState extends State<ParticipantRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
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
      body: Form(
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
            TextFormField(

            )
          ],
        ),
      ),
    );
  }
}
