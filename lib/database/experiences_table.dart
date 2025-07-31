import 'dart:math';

import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class ExperiencesTable{
  static const String createtable = '''
    CREATE TABLE $tableName(
      $idExperience INTEGER PRIMARY KEY NOT NULL,
      $name TEXT NOT NULL,
      $travelStopId INTEGER NOT NULL,
      FOREIGN KEY ($travelStopId) REFERENCES ${TravelStopTable.tableName}(${TravelStopTable.travelStopId})
    );
  ''';

  static const String tableName = 'travelStopExperiences';
  static const String idExperience = 'idExperience';
  static const String name = 'name';
  static const String travelStopId = 'travelStopId';

  static Map<String, dynamic> toMap(ExperienceType experience){
    return{
      idExperience: experience.index,
      name: experience.name,
    };
  }
}