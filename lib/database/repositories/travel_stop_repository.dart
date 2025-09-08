import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/repositories/travel_stop_repository.dart';
import 'dart:convert';

class TravelStopRepositoryImpl implements TravelStopRepository {
  const TravelStopRepositoryImpl();

  @override
  Future<void> insertMany(
    DatabaseExecutor txn,
    int travelId,
    List<TravelStop> stops,
  ) async {
    for (var stop in stops) {
      final data = Map<String, dynamic>.from(stop.toMap());
      if (data['experiences'] is! String) {
        data['experiences'] = jsonEncode(data['experiences']);
      }
      data['travelId'] = travelId;
      await txn.insert(
        'travel_stops',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<TravelStop>> getByTravelId(
    DatabaseExecutor txn,
    int travelId,
  ) async {
    final List<Map<String, dynamic>> maps = await txn.query(
      'travel_stops',
      where: 'travelId = ?',
      whereArgs: [travelId],
    );
    return List.generate(maps.length, (i) {
      final rawMap = maps[i];
      final experiencesRaw = rawMap['experiences'];
      List<int> decodedExperiences = [];
      if (experiencesRaw is String) {
        try {
          final dec = jsonDecode(experiencesRaw);
          if (dec is List)
            decodedExperiences = dec
                .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
                .toList();
        } catch (_) {
          decodedExperiences = [];
        }
      } else if (experiencesRaw is List) {
        decodedExperiences = experiencesRaw
            .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
            .toList();
      }
      final finalMap = {...rawMap, 'experiences': decodedExperiences};
      return TravelStop.fromMap(finalMap);
    });
  }

  @override
  Future<void> deleteByTravelId(DatabaseExecutor txn, int travelId) async {
    await txn.delete(
      'travel_stops',
      where: 'travelId = ?',
      whereArgs: [travelId],
    );
  }
}
