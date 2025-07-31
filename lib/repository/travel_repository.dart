import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/experiences_table.dart';
import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/database/travel_participant_table.dart';
import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/database/travel_table.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelController {
  Future<void> insert(Travel travel) async {
    final db = await TravelAppDatabase().getDatabase();

    await db.transaction((txn) async {
      final travelMap = TravelTable.toMap(travel);
      await txn.insert(TravelTable.tableName, travelMap);
      await _insertParticipant(txn, travel);
      await _insertStop(txn, travel);
    });
  }

  Future<void> _insertParticipant(DatabaseExecutor txn, Travel travel) async {
    for (final participant in travel.participants) {
      final participantMap = ParticipantTable.toMap(participant);
      await txn.insert(ParticipantTable.tableName, participantMap);

      final travelParticipantMap = {
        TravelParticipantTable.participantId: participant.participantId,
        TravelParticipantTable.travelId: travel.travelId,
      };
      await txn.insert(
          TravelParticipantTable.tableName, travelParticipantMap);
    }
  }

  Future<void> _insertStop(DatabaseExecutor txn, Travel travel) async {
    for (final stop in travel.stops) {
      final stopMap = TravelStopTable.toMap(stop);
      stopMap[TravelStopTable.travelId] = travel.travelId;
      await txn.insert(TravelStopTable.tableName, stopMap);
      for (final experience in stop.experiences) {
        final experienceMap = ExperiencesTable.toMap(experience);
        experienceMap[ExperiencesTable.travelStopId] = stop.travelStopId;
        await txn.insert(ExperiencesTable.tableName, experienceMap);
      }
    }
  }

  Future<List<Travel>> list() async {
    List<Travel> travels = [];
    try {
      final db = await TravelAppDatabase().getDatabase();
      final travelMaps = await db.query(TravelTable.tableName);
      final participantMaps = await db.query(ParticipantTable.tableName);
      final travelParticipantMaps = await db.query(TravelParticipantTable.tableName);
      final travelStopMaps = await db.query(TravelStopTable.tableName);
      final experienceMaps = await db.query(ExperiencesTable.tableName);

      travels = travelMaps.map((travelMap) {
        final travelId = travelMap[TravelTable.travelId] as int;
        final participants = _getParticipantsForTravel(travelId, participantMaps, travelParticipantMaps);
        final stops = _getStopsForTravel(travelId, travelStopMaps, experienceMaps);

        return Travel.fromMap({
          ...travelMap,
          'participants': participants,
          'stops': stops,
        });
      }).toList();
    } catch (e) {
      debugPrint('Erro ao listar viagens: $e');
    }

    return travels;
  }

  List<Participant> _getParticipantsForTravel(
      int travelId,
      List<Map<String, dynamic>> participantMaps,
      List<Map<String, dynamic>> travelParticipantMaps,
      ) {
    final participantIds = travelParticipantMaps
        .where((tp) => tp[TravelParticipantTable.travelId] == travelId)
        .map((tp) => tp[TravelParticipantTable.participantId])
        .toSet();

    return participantMaps
        .where((p) => participantIds.contains(p[ParticipantTable.participantId]))
        .map((p) => Participant.fromMap(p))
        .toList();
  }

  List<TravelStop> _getStopsForTravel(
      int travelId,
      List<Map<String, dynamic>> stopMaps,
      List<Map<String, dynamic>> experienceMaps,
      ) {
    return stopMaps
        .where((s) => s[TravelStopTable.travelId] == travelId)
        .map((stopMap) {
      final stopId = stopMap[TravelStopTable.travelStopId];
      final experiences = experienceMaps
          .where((e) => e[ExperiencesTable.travelStopId] == stopId)
          .map((e) => ExperienceType.values[e[ExperiencesTable.idExperience] as int])
          .toList();

      return TravelStop.fromMap({
        ...stopMap,
        'experiences': experiences,
      });
    }).toList();
  }
}
