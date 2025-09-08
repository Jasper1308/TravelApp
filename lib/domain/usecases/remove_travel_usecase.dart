import 'package:travel_app/domain/repositories/travel_repository.dart';

class RemoveTravelUseCase {
  final TravelRepository repository;
  RemoveTravelUseCase(this.repository);

  Future<void> call(int travelId) async {
    await repository.delete(travelId);
  }
}
