import 'package:travel_app/domain/entities/travel_stop_experience.dart';

abstract class TravelStopExperienceRepository {
  Future<int> insert(TravelStopExperience exp);
  Future<List<TravelStopExperience>> listByStop(int stopId);
  Future<void> delete(int id);
}
