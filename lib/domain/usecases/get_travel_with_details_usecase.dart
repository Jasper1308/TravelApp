import 'package:travel_app/domain/entities/travel_with_details.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';

class GetTravelWithDetailsUseCase {
  final TravelRepository repository;

  GetTravelWithDetailsUseCase(this.repository);

  Future<TravelWithDetails> call(int travelId) {
    return repository.getTravelWithDetails(travelId);
  }
}
