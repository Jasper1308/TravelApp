import 'package:travel_app/domain/entities/participant.dart';
import 'package:sqflite/sqflite.dart';

abstract class ParticipantRepository {
  Future<int> insertOrUpdate(DatabaseExecutor txn, Participant participant);
  Future<List<Participant>> listAll();
  Future<void> delete(int participantId);
  Future<List<Participant>> getByTravelId(DatabaseExecutor txn, int travelId);
}
