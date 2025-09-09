import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/tables/travel_table.dart';
import 'package:travel_app/database/tables/travel_stop_table.dart';
import 'package:travel_app/database/tables/participant_table.dart';
import 'package:travel_app/database/tables/travel_participant_table.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel_with_details.dart';
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

  @override
  Future<Travel?> getById(int id) async {
    final db = await _db.getDatabase();
    final maps = await db.query(
      TravelTable.tableName,
      where: '${TravelTable.travelId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Travel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<TravelWithDetails> getTravelWithDetails(int id) async {
    final db = await _db.getDatabase();

    final travelMaps = await db.query(
      TravelTable.tableName,
      where: '${TravelTable.travelId} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (travelMaps.isEmpty) {
      throw Exception('Travel with ID $id not found.');
    }
    final travel = Travel.fromMap(travelMaps.first);

    final stopMaps = await db.query(
      TravelStopTable.tableName,
      where: '${TravelStopTable.travelId} = ?',
      whereArgs: [id],
    );
    final stops = stopMaps.map((map) => TravelStop.fromMap(map)).toList();

    final participantIds = await db.query(
      TravelParticipantTable.tableName,
      where: '${TravelParticipantTable.travelId} = ?',
      whereArgs: [id],
    );
    final ids = participantIds
        .map((e) => e[TravelParticipantTable.participantId] as int)
        .toList();

    final participants = ids.isEmpty
        ? <Participant>[]
        : (await db.query(
            ParticipantTable.tableName,
            where:
                '${ParticipantTable.participantId} IN (${List.filled(ids.length, '?').join(',')})',
            whereArgs: ids,
          )).map((map) => Participant.fromMap(map)).toList();

    return TravelWithDetails(
      travel: travel,
      stops: stops,
      participants: participants,
    );
  }
}
