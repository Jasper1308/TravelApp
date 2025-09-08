import 'package:travel_app/database/database.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';
import 'package:travel_app/domain/repositories/travel_stop_repository.dart';

/// Fetch travels and attach related stops and participants.
/// Uses parallel requests per travel to avoid blocking on sequential IO.
/// If you later add bulk repository methods (getByTravelIds) you can improve performance further.
class GetTravelsWithDetailsUseCase {
  final TravelRepository _travelRepo;
  final TravelStopRepository _stopRepo;
  final ParticipantRepository _participantRepo;
  final TravelAppDatabase _db;

  GetTravelsWithDetailsUseCase(
    this._travelRepo,
    this._stopRepo,
    this._participantRepo,
    this._db,
  );

  Future<List<Travel>> call() async {
    final db = await _db.getDatabase();
    final travels = await _travelRepo.listAll();

    // Parallelize per travel - still N queries but concurrent.
    final futures = travels.map((travel) async {
      final stops = await _stopRepo.getByTravelId(db, travel.travelId);
      final participants = await _participantRepo.getByTravelId(db, travel.travelId);
      return travel.copyWith(stops: stops, participants: participants);
    }).toList();

    return await Future.wait(futures);
  }
}
