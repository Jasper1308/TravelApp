import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travel_app/database/tables/experiences_table.dart';
import 'package:travel_app/database/tables/participant_table.dart';
import 'package:travel_app/database/tables/travel_participant_table.dart';
import 'package:travel_app/database/tables/travel_stop_table.dart';
import 'package:travel_app/database/tables/travel_table.dart';

class TravelAppDatabase {
  static const _dbName = 'travel_app.db';
  static const _dbVersion = 2;

  Future<Database> getDatabase() async {
    final dbPath = join(await getDatabasesPath(), _dbName);

    return openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute(TravelTable.createTable);
        await db.execute(TravelStopTable.createTable);
        await db.execute(ParticipantTable.createTable);
        await db.execute(ExperiencesTable.createTable);
        await db.execute(TravelParticipantTable.createTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(TravelStopTable.createTable);
        }
      },
    );
  }
}
