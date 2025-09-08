import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/tables/travel_table.dart';
import 'package:travel_app/database/tables/travel_participant_table.dart'; // Importe a nova tabela
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';

class TravelRepositoryImpl implements TravelRepository {
  final TravelAppDatabase _db;

  TravelRepositoryImpl(this._db);

  @override
  Future<int> insert(DatabaseExecutor txn, Travel travel) async {
    return await txn.insert(
      TravelTable.tableName,
      travel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Travel>> listAll() async {
    final db = await _db.getDatabase();
    final maps = await db.query(TravelTable.tableName);
    return List.generate(maps.length, (i) => Travel.fromMap(maps[i]));
  }

  @override
  Future<void> delete(int travelId) async {
    final db = await _db.getDatabase();
    await db.delete(
      TravelTable.tableName,
      where: '${TravelTable.travelId} = ?',
      whereArgs: [travelId],
    );
  }

  @override
  Future<void> associateParticipantWithTravel(
    int participantId,
    int travelId,
  ) async {
    final db = await _db.getDatabase();
    await db.insert(
      TravelParticipantTable.tableName,
      {
        TravelParticipantTable.participantId: participantId,
        TravelParticipantTable.travelId: travelId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
