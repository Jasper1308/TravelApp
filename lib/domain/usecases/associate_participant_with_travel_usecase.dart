import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';

abstract class AssociateParticipantWithTravelUseCase {
  Future<void> call(int participantId, int travelId, {DatabaseExecutor? txn});
}

class AssociateParticipantWithTravelUseCaseImpl implements AssociateParticipantWithTravelUseCase {
  final TravelRepository _travelRepository;
  final Future<Database> _db;

  AssociateParticipantWithTravelUseCaseImpl(this._travelRepository, this._db);

  @override
  Future<void> call(int participantId, int travelId, {DatabaseExecutor? txn}) async {
    if (txn != null) {
      await _travelRepository.associateParticipantWithTravel(txn, participantId, travelId);
      return;
    }
    final db = await _db;
    await db.transaction((t) async {
      await _travelRepository.associateParticipantWithTravel(t, participantId, travelId);
    });
  }
}
