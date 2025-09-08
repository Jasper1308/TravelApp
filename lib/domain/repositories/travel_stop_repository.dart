import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:sqflite/sqflite.dart';

abstract class TravelStopRepository {
  Future<void> insertMany(DatabaseExecutor txn, int travelId, List<TravelStop> stops);
  Future<List<TravelStop>> getByTravelId(DatabaseExecutor db, int travelId);
  Future<void> deleteByTravelId(DatabaseExecutor txn, int travelId);
}
