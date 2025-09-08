import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/domain/usecases/add_stop_usecase.dart';
import 'package:travel_app/domain/usecases/get_stop_date_usecase.dart';
import 'package:travel_app/domain/usecases/create_travel_usecase.dart';
import 'package:travel_app/domain/usecases/reorder_stop_usecase.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelRegisterProvider extends ChangeNotifier {
  final CreateTravelUseCase _saveTravel;
  final AddStopUseCase _addStopUseCase;
  final GetStopDateUseCase _getStopDateUseCase;
  final ReorderStopsUseCase _reorderStopsUseCase;

  TravelRegisterProvider(
    this._saveTravel,
    this._addStopUseCase,
    this._getStopDateUseCase,
    this._reorderStopsUseCase,
  );

  String name = '';
  DateTime? initialDate;
  DateTime? endDate;
  TransportType transport = TransportType.car;
  final List<TravelStop> stops = [];
  final List<Participant> participants = [];
  int? travelId;

  int get totalDays {
    if (initialDate == null || endDate == null) return 0;
    final days = endDate!.difference(initialDate!).inDays + 1;
    return max(0, days);
  }

  DateTime? dateForStop(TravelStop stop) {
    return _getStopDateUseCase.call(initialDate, stop);
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

  Future<void> addStopFromCoordinates(
    LatLng coords, {
    required String description,
    required int lengthStay,
    required List<ExperienceType> experiences,
    required DateTime arrivalDate,
    required DateTime departureDate,
  }) async {
    final newStop = await _addStopUseCase.call(
      coordinates: coords,
      description: description,
      experiences: experiences,
      lengthStay: lengthStay,
      stopOrder: stops.length,
      travelId: travelId ?? 0,
      arrivalDate: arrivalDate,
      departureDate: departureDate,
    );
    stops.add(newStop);
    notifyListeners();
  }

  void removeStop(TravelStop stop) {
    stops.removeWhere((s) => s.travelStopId == stop.travelStopId);
    notifyListeners();
  }

  void reorderStops(int oldIndex, int newIndex) {
    _reorderStopsUseCase.call(stops, oldIndex, newIndex, totalDays);
    notifyListeners();
  }

  void setStopDay(TravelStop stop, int dayIndex) {
    final index = stops.indexWhere((s) => s.travelStopId == stop.travelStopId);
    if (index != -1) {
      stops[index] = stop.copyWith(dayIndex: dayIndex);
      notifyListeners();
    }
  }

  void toggleParticipant(Participant p) {
    final isPresent = participants.any(
      (e) => e.participantId == p.participantId,
    );
    if (isPresent) {
      participants.removeWhere((e) => e.participantId == p.participantId);
    } else {
      participants.add(p);
    }
    notifyListeners();
  }

  void removeParticipant(Participant p) {
    participants.removeWhere(
      (participant) => participant.participantId == p.participantId,
    );
    notifyListeners();
  }

  Future<int> save() async {
    if (name.trim().isEmpty) throw Exception('Nome obrigatório');
    if (initialDate == null || endDate == null) throw Exception('Período inválido');
    if (initialDate!.isAfter(endDate!)) throw Exception('Data inicial maior que data final');
    final travel = Travel(
      travelId: travelId ?? 0,
      name: name,
      initialDate: initialDate!,
      endDate: endDate!,
      transportType: transport,
      stops: List.from(stops),
      participants: List.from(participants),
    );
    final id = await _saveTravel.call(
      travel,
      List.from(stops),
      List.from(participants),
    );
    travelId = id;
    resetState(preserveTravelId: true);
    return id;
  }

  void resetState({bool preserveTravelId = false}) {
    name = '';
    initialDate = null;
    endDate = null;
    transport = TransportType.car;
    stops.clear();
    participants.clear();
    if (!preserveTravelId) travelId = null;
    notifyListeners();
  }
}
