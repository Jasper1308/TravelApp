import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';
import 'package:travel_app/domain/repositories/travel_stop_repository.dart';

class CreateTravelUseCase {
  final TravelRepository _travelRepo;
  final TravelStopRepository _stopRepo;
  final ParticipantRepository _participantRepo;
  final Future<Database> _db;

  CreateTravelUseCase(
      this._travelRepo,
      this._stopRepo,
      this._participantRepo,
      this._db,
      );

  Future<int> call({
    required Travel travel,
    required List<TravelStop> stops,
    required List<Participant> participants,
  }) async {
    if (travel.name.trim().isEmpty) throw Exception('Nome obrigatório');
    if (travel.initialDate.isAfter(travel.endDate)) {
      throw Exception('Data inicial maior que data final');
    }

    for (final stop in stops) {
      if (stop.arrivalDate.isBefore(travel.initialDate) || stop.departureDate.isAfter(travel.endDate)) {
        throw Exception('A parada "${stop.placeName}" está fora do período da viagem.');
      }
    }

    final db = await _db;

    return await db.transaction((txn) async {
      int travelId;
      if (travel.travelId == 0) {
        travelId = await _travelRepo.insert(txn, travel);
      } else {
        await _travelRepo.update(txn, travel);
        travelId = travel.travelId;
      }

      await _stopRepo.deleteByTravelId(txn, travelId);
      await _travelRepo.unassociateAllParticipants(txn, travelId);

      final stopsWithIds = stops.map((s) => s.copyWith(travelId: travelId)).toList();
      await _stopRepo.insertMany(txn, travelId, stopsWithIds);

      for (final p in participants) {
        final participantId = await _participantRepo.insertOrUpdate(txn, p);
        await _travelRepo.associateParticipantWithTravel(txn, participantId, travelId);
      }

      return travelId;
    });
  }
}