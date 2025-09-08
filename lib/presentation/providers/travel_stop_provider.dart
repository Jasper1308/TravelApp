import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/usecases/add_stop_usecase.dart';
import 'package:travel_app/domain/usecases/reorder_stop_usecase.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopProvider extends ChangeNotifier {
  final AddStopUseCase _addStop;
  final ReorderStopsUseCase _reorderStops;

  TravelStopProvider(this._addStop, this._reorderStops);

  final List<TravelStop> _stops = [];

  List<TravelStop> get stops => List.unmodifiable(_stops);

  Future<void> addStop({
    required LatLng coordinates,
    required String description,
    required List<ExperienceType> experiences,
    required int lengthStay,
    required int travelId,
    required DateTime arrivalDate,
    required DateTime departureDate,
  }) async {
    final stopOrder = _stops.length;
    final newStop = await _addStop.call(
      coordinates: coordinates,
      description: description,
      experiences: experiences,
      lengthStay: lengthStay,
      stopOrder: stopOrder,
      travelId: travelId,
      arrivalDate: arrivalDate,
      departureDate: departureDate,
    );
    _stops.add(newStop);
    notifyListeners();
  }

  void removeStop(TravelStop stop) {
    _stops.removeWhere((s) => s.travelStopId == stop.travelStopId);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex, int totalDays) {
    _reorderStops.call(_stops, oldIndex, newIndex, totalDays);
    notifyListeners();
  }

  void clearStops() {
    _stops.clear();
    notifyListeners();
  }
}
