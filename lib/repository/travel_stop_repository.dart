import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/experiences_table.dart';
import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopRepository {
  Future<void> insert(
    DatabaseExecutor txn,
    int travelId,
    List<TravelStop> stops,
  ) async {
    for (final stop in stops) {
      final stopMap = TravelStopTable.toMap(stop);
      stopMap[TravelStopTable.travelId] = travelId;
      final stopId = await txn.insert(TravelStopTable.tableName, stopMap);
      stop.travelStopId = stopId;

      for (final experience in stop.experiences) {
        final experienceMap = ExperiencesTable.toMap(experience);
        experienceMap[ExperiencesTable.travelStopId] = stop.travelStopId;
        await txn.insert(ExperiencesTable.tableName, experienceMap);
      }
    }
  }

  Future<List<TravelStop>> getByTravelId(
    int travelId,
    List<Map<String, dynamic>> allStopMaps,
    List<Map<String, dynamic>> allExperienceMaps,
  ) async {
    return allStopMaps
        .where((s) => s[TravelStopTable.travelId] == travelId)
        .map((stopMap) {
          final stopId = stopMap[TravelStopTable.travelStopId];
          final experiences = allExperienceMaps
              .where((e) => e[ExperiencesTable.travelStopId] == stopId)
              .map(
                (e) =>
                    ExperienceType.values[e[ExperiencesTable.idExperience]
                        as int],
              )
              .toList();

          return TravelStop.fromMap({...stopMap, 'experiences': experiences});
        })
        .toList();
  }

  Future<void> deleteByTravelId(DatabaseExecutor txn, int travelId) async {
    await txn.delete(
      TravelStopTable.tableName,
      where: '${TravelStopTable.travelId} = ?',
      whereArgs: [travelId],
    );
  }
}
