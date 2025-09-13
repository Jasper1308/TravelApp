import 'package:travel_app/domain/repositories/travel_stop_experience_repository.dart';

class RemoveExperienceUseCase {
  final TravelStopExperienceRepository repository;
  RemoveExperienceUseCase(this.repository);

  Future<void> call(int id) => repository.delete(id);
}
