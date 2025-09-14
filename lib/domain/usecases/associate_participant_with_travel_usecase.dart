import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';

abstract class AssociateParticipantWithTravelUseCase {
  Future<void> call(int participantId, int travelId);
}

class AssociateParticipantWithTravelUseCaseImpl implements AssociateParticipantWithTravelUseCase {
  final TravelRepository _travelRepository;
  final Future<Database> _db;

  AssociateParticipantWithTravelUseCaseImpl(this._travelRepository, this._db);

  @override
  Future<void> call(int participantId, int travelId) async {
    final db = await _db;

    return await db.transaction((txn) async {
      await _travelRepository.associateParticipantWithTravel(txn, participantId, travelId);
    });
  }
}