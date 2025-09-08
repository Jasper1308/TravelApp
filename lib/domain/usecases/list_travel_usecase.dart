import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';

class ListTravelsUseCase {
  final TravelRepository repository;
  ListTravelsUseCase(this.repository);

  Future<List<Travel>> call() async {
    return await repository.listAll();
  }
}