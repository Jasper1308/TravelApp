import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/presentation/providers/experience_provider.dart';

class TravelStopExperienceScreen extends StatefulWidget {
  final int stopId;

  const TravelStopExperienceScreen({super.key, required this.stopId});

  @override
  State<TravelStopExperienceScreen> createState() => _TravelStopExperienceScreenState();
}

class _TravelStopExperienceScreenState extends State<TravelStopExperienceScreen> {
  final _controller = TextEditingController();
  File? _selectedPhoto;

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedPhoto = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExperienceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Experiência")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.experiences.length,
              itemBuilder: (context, index) {
                final exp = provider.experiences[index];
                return Card(
                  child: ListTile(
                    leading: exp.photoPath != null ? Image.file(File(exp.photoPath!)) : null,
                    title: Text(exp.comment ?? "Sem comentário"),
                    subtitle: Text("Criado em: ${exp.createdAt.toLocal()}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.removeExperience(exp.id!, widget.stopId),
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Comentário",
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pickPhoto,
                icon: const Icon(Icons.photo),
                label: const Text("Foto"),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  final exp = TravelStopExperience(
                    stopId: widget.stopId,
                    comment: _controller.text,
                    photoPath: _selectedPhoto?.path,
                  );
                  await provider.addExperience(exp);
                  _controller.clear();
                  setState(() => _selectedPhoto = null);
                },
                icon: const Icon(Icons.save),
                label: const Text("Salvar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
