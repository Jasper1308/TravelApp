import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/domain/repositories/travel_stop_experience_repository.dart';

class AddExperienceUseCase {
  final TravelStopExperienceRepository repository;
  AddExperienceUseCase(this.repository);

  Future<int> call(TravelStopExperience exp) => repository.insert(exp);
}
