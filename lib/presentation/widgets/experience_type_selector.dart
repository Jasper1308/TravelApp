import 'package:flutter/material.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class ExperienceTypeSelector extends StatefulWidget {
  final List<ExperienceType> selectedExperiences;
  final ValueSetter<List<ExperienceType>> onExperiencesSelected;

  const ExperienceTypeSelector({
    super.key,
    required this.selectedExperiences,
    required this.onExperiencesSelected,
  });

  @override
  State<ExperienceTypeSelector> createState() => _ExperienceTypeSelectorState();
}

class _ExperienceTypeSelectorState extends State<ExperienceTypeSelector> {
  late List<ExperienceType> _selectedExperiences;

  @override
  void initState() {
    super.initState();
    _selectedExperiences = List.from(widget.selectedExperiences);
  }

  void _toggleExperience(ExperienceType experience) {
    setState(() {
      if (_selectedExperiences.contains(experience)) {
        _selectedExperiences.remove(experience);
      } else {
        _selectedExperiences.add(experience);
      }
      widget.onExperiencesSelected(List.from(_selectedExperiences));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ExperienceType.values.map((experience) {
        final isSelected = _selectedExperiences.contains(experience);
        return ChoiceChip(
          label: Text(experience.intlString(context)),
          selected: isSelected,
          onSelected: (_) => _toggleExperience(experience),
          selectedColor: Colors.blue,
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
