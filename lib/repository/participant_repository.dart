import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/domain/entities/participant.dart';

class ParticipantRepository {
  Future<int> insertOrUpdate(
    DatabaseExecutor txn,
    Participant participant,
  ) async {
    final existingParticipant = await txn.query(
      ParticipantTable.tableName,
      where: '${ParticipantTable.name} = ?',
      whereArgs: [participant.name],
    );

    if (existingParticipant.isNotEmpty) {
      return existingParticipant.first[ParticipantTable.participantId] as int;
    } else {
      return await txn.insert(
        ParticipantTable.tableName,
        ParticipantTable.toMap(participant),
      );
    }
  }

  Future<List<Participant>> getAll() async {
    final db = await TravelAppDatabase().getDatabase();
    final maps = await db.query(ParticipantTable.tableName);
    return List.generate(maps.length, (i) => Participant.fromMap(maps[i]));
  }

  Future<void> delete(DatabaseExecutor txn, int participantId) async {
    await txn.delete(
      ParticipantTable.tableName,
      where: '${ParticipantTable.participantId} = ?',
      whereArgs: [participantId],
    );
  }
}
