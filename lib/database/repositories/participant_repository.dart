import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/tables/participant_table.dart';
import 'package:travel_app/database/tables/travel_participant_table.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';

class ParticipantRepositoryImpl implements ParticipantRepository {
  final TravelAppDatabase _db;

  ParticipantRepositoryImpl(this._db);

  @override
  Future<int> insertOrUpdate(
    DatabaseExecutor txn,
    Participant participant,
  )
  async {
    print("Inserindo participante: ${participant.toMap()}");
    final exists = await txn.query(
      ParticipantTable.tableName,
      where: '${ParticipantTable.name} = ?',
      whereArgs: [participant.name],
    );
    if (exists.isNotEmpty) {
      return exists.first[ParticipantTable.participantId] as int;
    }
    final map = Map<String, dynamic>.from(participant.toMap())
      ..remove('participantId');
    return await txn.insert(ParticipantTable.tableName, map);
  }

  @override
  Future<List<Participant>> getByTravelId(
    DatabaseExecutor txn,
    int travelId,
  ) async {
    const table = TravelParticipantTable.tableName;
    const participantTable = ParticipantTable.tableName;
    const participantIdColumn = ParticipantTable.participantId;
    const travelIdColumn = TravelParticipantTable.travelId;
    final rows = await txn.query(
      table,
      columns: ['*'],
      where: '$travelIdColumn = ?',
      whereArgs: [travelId],
    );
    if (rows.isEmpty) return [];
    final participantIds = rows
        .map((e) => e[TravelParticipantTable.participantId] as int?)
        .where((id) => id != null)
        .cast<int>()
        .toList();
    if (participantIds.isEmpty) return [];
    final placeholders = List.filled(participantIds.length, '?').join(',');
    final participants = await txn.query(
      participantTable,
      where: '$participantIdColumn IN ($placeholders)',
      whereArgs: participantIds,
    );
    return participants.map((e) => Participant.fromMap(e)).toList();
  }

  @override
  Future<List<Participant>> listAll({DatabaseExecutor? txn}) async {
    final dbExecutor = txn ?? await _db.getDatabase();
    final rows = await dbExecutor.query(
      ParticipantTable.tableName,
      orderBy: '${ParticipantTable.participantId} DESC',
    );
    return rows.map((r) => Participant.fromMap(r)).toList();
  }



  @override
  Future<void> delete(int participantId,{DatabaseExecutor? txn}) async {
    final dbExecutor = txn ?? await _db.getDatabase();
    await dbExecutor.delete(
      ParticipantTable.tableName,
      where: '${ParticipantTable.participantId} = ?',
      whereArgs: [participantId],
    );
  }
}
