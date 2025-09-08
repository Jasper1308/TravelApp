import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/repositories/travel_repository.dart';
import 'package:travel_app/domain/repositories/travel_stop_repository.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';

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

  Future<int> call(
      Travel travel,
      List<TravelStop> stops,
      List<Participant> participants,
      ) async {
    final db = await _db;
    return await db.transaction<int>((txn) async {
      final travelId = (await _travelRepo.insert(txn, travel));

      await _stopRepo.insertMany(txn, travelId, stops);

      for (final p in participants) {
        await _participantRepo.insertOrUpdate(txn, p);
      }

      return travelId;
    });
  }
}