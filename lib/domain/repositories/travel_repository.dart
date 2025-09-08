import 'package:travel_app/domain/entities/travel.dart';
import 'package:sqflite/sqflite.dart';

abstract class TravelRepository {
  Future<int> insert(DatabaseExecutor txn, Travel travel);
  Future<List<Travel>> listAll();
  Future<void> delete(int travelId);
  Future<void> associateParticipantWithTravel(int participantId, int travelId);
}
