import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/experience_provider.dart';

class TravelStopExperienceScreen extends StatefulWidget {
  final int stopId;

  const TravelStopExperienceScreen({super.key, required this.stopId});

  @override
  State<TravelStopExperienceScreen> createState() => _TravelStopExperienceScreenState();
}

class _TravelStopExperienceScreenState extends State<TravelStopExperienceScreen> {
  final _commentController = TextEditingController();
  File? _selectedPhoto;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExperienceProvider>().loadExperiences(widget.stopId);
    });
  }

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedPhoto = File(picked.path));
    }
  }

  Future<void> _saveExperience() async {
    final provider = context.read<ExperienceProvider>();
    final exp = TravelStopExperience(
      stopId: widget.stopId,
      comment: _commentController.text.trim(),
      photoPath: _selectedPhoto?.path,
    );
    await provider.addExperience(exp);
    _commentController.clear();
    setState(() => _selectedPhoto = null);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExperienceProvider>();
    final l10n = AppLocalizations.of(context)!;
    final experiences = provider.experiences;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.registerExperience),
      ),
      body: Column(
        children: [
          Expanded(
            child: experiences.isEmpty
                ? Center(
              child: Text(
                l10n.noComment,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
                : ListView.builder(
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (exp.photoPath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(exp.photoPath!),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          exp.comment ?? l10n.noComment,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.createdAt(
                            exp.createdAt.toLocal().toString().split('.')[0],
                          ),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => provider.removeExperience(exp.id!, widget.stopId),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: l10n.comment,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _selectedPhoto != null
                          ? Image.file(
                        _selectedPhoto!,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : ElevatedButton.icon(
                        onPressed: _pickPhoto,
                        icon: const Icon(Icons.photo),
                        label: Text(l10n.photo),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _saveExperience,
                        icon: const Icon(Icons.save),
                        label: Text(l10n.save),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}