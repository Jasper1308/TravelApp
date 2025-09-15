import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/domain/usecases/create_travel_usecase.dart';
import 'package:travel_app/domain/usecases/get_stop_date_usecase.dart';
import 'dart:math';

class TravelRegisterProvider extends ChangeNotifier {
  final CreateTravelUseCase _createTravel;
  final GetStopDateUseCase _getStopDateUseCase;

  TravelRegisterProvider(this._createTravel, this._getStopDateUseCase);

  String name = '';
  DateTime? initialDate;
  DateTime? endDate;
  TransportType transport = TransportType.car;
  final List<Participant> participants = [];
  int? travelId;

  int get totalDays {
    if (initialDate == null || endDate == null) return 0;
    final days = endDate!.difference(initialDate!).inDays + 1;
    return max(0, days);
  }

  DateTime? dateForStop(TravelStop stop, List<TravelStop> stops) {
    return _getStopDateUseCase(initialDate, stop, stops);
  }

  void setBasic({
    String? name,
    DateTime? start,
    DateTime? end,
    TransportType? transportType,
  }) {
    if (name != null) this.name = name;
    if (start != null) initialDate = start;
    if (end != null) endDate = end;
    if (transportType != null) transport = transportType;
    notifyListeners();
  }

  void toggleParticipant(Participant participant) {
    final exists = participants.any((p) => p.participantId == participant.participantId);
    if (exists) {
      participants.removeWhere((p) => p.participantId == participant.participantId);
    } else {
      participants.add(participant);
    }
    notifyListeners();
  }

  Future<int> save({required List<TravelStop> stopsToSave}) async {
    final travel = Travel(
      travelId: travelId ?? 0,
      name: name,
      initialDate: initialDate!,
      endDate: endDate!,
      transportType: transport,
    );

    final id = await _createTravel.call(
      travel: travel,
      stops: stopsToSave,
      participants: participants,
    );

    travelId = id;
    resetState();
    return id;
  }

  void resetState() {
    name = '';
    initialDate = null;
    endDate = null;
    transport = TransportType.car;
    participants.clear();
    travelId = null;
    notifyListeners();
  }
}
