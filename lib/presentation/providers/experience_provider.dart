import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/domain/usecases/add_experience_usecase.dart';
import 'package:travel_app/domain/usecases/list_experiences_usecase.dart';
import 'package:travel_app/domain/usecases/remove_experience_usecase.dart';

class ExperienceProvider extends ChangeNotifier {
  final AddExperienceUseCase _add;
  final ListExperiencesUseCase _list;
  final RemoveExperienceUseCase _remove;

  ExperienceProvider(this._add, this._list, this._remove);

  List<TravelStopExperience> _experiences = [];
  List<TravelStopExperience> get experiences => List.unmodifiable(_experiences);

  Future<void> loadExperiences(int stopId) async {
    _experiences = await _list(stopId);
    notifyListeners();
  }

  Future<void> addExperience(TravelStopExperience exp) async {
    await _add(exp);
    await loadExperiences(exp.stopId);
  }

  Future<void> removeExperience(int id, int stopId) async {
    await _remove(id);
    await loadExperiences(stopId);
  }
}
