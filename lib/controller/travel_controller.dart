import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_app/database/experiences_table.dart';
import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/database/travel_participant_table.dart';
import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/repository/participant_repository.dart';
import 'package:travel_app/repository/travel_repository.dart';
import 'package:travel_app/repository/travel_stop_repository.dart';

class TravelController {
  final TravelRepository _travelRepository = TravelRepository();
  final TravelStopRepository _travelStopRepository = TravelStopRepository();
  final ParticipantRepository _participantRepository = ParticipantRepository();

  Future<void> create(Travel travel) async{
    final db = await TravelAppDatabase().getDatabase();

    await db.transaction((txn) async{
      final travelId = await _travelRepository.insert(txn, travel);
      travel.travelId = travelId;

      await _insertParticipantsAndLink(txn, travel);
      await _travelStopRepository.insert(txn, travel.travelId, travel.stops);
    });
  }

  Future<List<Travel>> listAll() async {
    List<Travel> travels = [];
    try {
      final db = await TravelAppDatabase().getDatabase();
      final travelMaps = await _travelRepository.getAllTravelMaps(db);
      final participantMaps = await db.query(ParticipantTable.tableName);
      final travelParticipantMaps = await db.query(TravelParticipantTable.tableName);
      final travelStopMaps = await db.query(TravelStopTable.tableName);
      final experienceMaps = await db.query(ExperiencesTable.tableName);

      travels = travelMaps.map((travelMap) {
        final travelId = travelMap['travelId'] as int;
        final participants = _getParticipantsForTravel(
          travelId,
          participantMaps,
          travelParticipantMaps,
        );
        final stops = _travelStopRepository.getByTravelId(
          travelId,
          travelStopMaps,
          experienceMaps,
        );

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

  Future<void> delete(int id) async {
    final db = await TravelAppDatabase().getDatabase();

    await db.transaction((txn) async {
      await txn.delete(
        TravelParticipantTable.tableName,
        where: '${TravelParticipantTable.travelId} = ?',
        whereArgs: [id],
      );

      await _travelStopRepository.deleteByTravelId(txn, id);
    });
  }

  Future<void> _insertParticipantsAndLink(DatabaseExecutor txn, Travel travel) async {
    for (final participant in travel.participants) {
      final participantId = await _participantRepository.insertOrUpdate(txn, participant);

      final travelParticipantMap = {
        TravelParticipantTable.participantId: participantId,
        TravelParticipantTable.travelId: travel.travelId,
      };
      await txn.insert(TravelParticipantTable.tableName, travelParticipantMap);
    }
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
}
