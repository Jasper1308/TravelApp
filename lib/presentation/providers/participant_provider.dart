import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/usecases/associate_participant_with_travel_usecase.dart';
import 'package:travel_app/domain/usecases/create_participant_usecase.dart';
import 'package:travel_app/domain/usecases/list_participants_usecase.dart';
import 'package:travel_app/domain/usecases/remove_participant_usecase.dart';

class ParticipantProvider extends ChangeNotifier {
  final CreateParticipantUseCase _createParticipant;
  final ListParticipantsUseCase _listParticipants;
  final RemoveParticipantUseCase _removeParticipant;
  final AssociateParticipantWithTravelUseCase _associateWithTravel;

  ParticipantProvider(
      this._createParticipant,
      this._listParticipants,
      this._removeParticipant,
      this._associateWithTravel,
      );

  List<Participant> _participants = [];

  List<Participant> get participants => List.unmodifiable(_participants);

  Future<void> loadParticipants() async {
    _participants = await _listParticipants();
    notifyListeners();
  }

  Future<void> addParticipant(Participant participant) async {
    await _createParticipant(participant);
    await loadParticipants();
  }

  Future<void> removeParticipant(int id) async {
    await _removeParticipant(id);
    await loadParticipants();
  }

  Future<void> associateWithTravel(int participantId, int travelId, [DatabaseExecutor? txn]) async {
    await _associateWithTravel(participantId, travelId, txn: txn);
  }
}
