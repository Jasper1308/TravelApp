import 'package:travel_app/database/tables/travel_stop_table.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class ExperiencesTable {
  static const String tableName = 'travel_stop_experiences';
  static const String idExperience = 'idExperience';
  static const String name = 'name';
  static const String travelStopId = 'travelStopId';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $idExperience INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $travelStopId INTEGER NOT NULL,
      FOREIGN KEY ($travelStopId) REFERENCES ${TravelStopTable.tableName}(${TravelStopTable.travelStopId})
    );
  ''';

  static Map<String, dynamic> toMap(ExperienceType experience) {
    return {
      name: experience.name,
    };
  }
}
