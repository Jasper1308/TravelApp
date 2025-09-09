import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_with_details.dart';

abstract class TravelRepository {
  Future<int> insert(DatabaseExecutor txn, Travel travel);
  Future<List<Travel>> listAll();
  Future<void> delete(int travelId);
  Future<void> associateParticipantWithTravel(int participantId, int travelId);
  Future<Travel?> getById(int id);
  Future<TravelWithDetails> getTravelWithDetails(int travelId);
}
