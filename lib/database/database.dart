import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travel_app/database/experiences_table.dart';
import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/database/travel_participant_table.dart';
import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/database/travel_table.dart';

class TravelAppDatabase{
  Future<Database> getDatabase() async{
    final dbPath = join(
        await getDatabasesPath(),
        'travel_app.db'
    );
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        db.execute(TravelTable.createTable);
        db.execute(TravelStopTable.createTable);
        db.execute(ParticipantTable.createTable);
        db.execute(ExperiencesTable.createtable);
        db.execute(TravelParticipantTable.createTable);
      },
    );
  }
}