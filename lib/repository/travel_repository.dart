import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/travel_table.dart';
import 'package:travel_app/domain/entities/travel.dart';

class TravelRepository {
  Future<int> insert(DatabaseExecutor txn, Travel travel) async {
    return await txn.insert(TravelTable.tableName, TravelTable.toMap(travel));
  }
  Future<List<Map<String, dynamic>>> getAllTravelMaps(DatabaseExecutor db) async {
    return await db.query(TravelTable.tableName);
  }
}
