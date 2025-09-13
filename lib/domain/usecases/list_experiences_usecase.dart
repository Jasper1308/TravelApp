import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/domain/repositories/travel_stop_experience_repository.dart';

class ListExperiencesUseCase {
  final TravelStopExperienceRepository repository;
  ListExperiencesUseCase(this.repository);

  Future<List<TravelStopExperience>> call(int stopId) =>
      repository.listByStop(stopId);
}
