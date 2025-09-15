import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/tables/travel_stop_experience_table.dart';
import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/domain/repositories/travel_stop_experience_repository.dart';

class TravelStopExperienceRepositoryImpl implements TravelStopExperienceRepository {
  final TravelAppDatabase _db;

  TravelStopExperienceRepositoryImpl(this._db);

  @override
  Future<int> insert(TravelStopExperience exp) async {
    final db = await _db.getDatabase();
    return await db.insert(
      TravelStopExperienceTable.tableName,
      exp.toMap(),
    );
  }

  @override
  Future<List<TravelStopExperience>> listByStop(int stopId) async {
    final db = await _db.getDatabase();
    final maps = await db.query(
      TravelStopExperienceTable.tableName,
      where: "${TravelStopExperienceTable.stopId} = ?",
      whereArgs: [stopId],
    );
    return List.generate(maps.length, (i) => TravelStopExperience.fromMap(maps[i]));
  }

  @override
  Future<void> delete(int id) async {
    final db = await _db.getDatabase();
    await db.delete(
      TravelStopExperienceTable.tableName,
      where: "${TravelStopExperienceTable.id} = ?",
      whereArgs: [id],
    );
  }
}
