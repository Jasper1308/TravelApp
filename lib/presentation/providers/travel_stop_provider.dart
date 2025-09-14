import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/usecases/reorder_stop_usecase.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopProvider extends ChangeNotifier {
  final ReorderStopsUseCase _reorderStops;

  TravelStopProvider(this._reorderStops);

  final List<TravelStop> _stops = [];

  List<TravelStop> get stops => List.unmodifiable(_stops);

  Future<void> addStop({
    required LatLng coordinates,
    required String placeName,
    required String description,
    required List<ExperienceType> experiences,
    required int lengthStay,
    required DateTime arrivalDate,
    required DateTime departureDate,
  }) async {
    final stopOrder = _stops.length;
    final newStop = TravelStop(
      travelStopId: 0,
      travelId: 0,
      placeName: placeName,
      description: description,
      coordinates: coordinates,
      dayIndex: 0,
      lengthStay: lengthStay,
      stopOrder: stopOrder,
      experiences: experiences,
      arrivalDate: arrivalDate,
      departureDate: departureDate,
    );
    _stops.add(newStop);
    _recalculateDayIndices();
    notifyListeners();
  }

  void removeStop(TravelStop stop) {
    _stops.removeWhere(
            (s) => s.placeName == stop.placeName && s.description == stop.description);
    _recalculateDayIndices();
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex, int totalDays) {
    _reorderStops.call(_stops, oldIndex, newIndex, totalDays);
    notifyListeners();
  }

  void _recalculateDayIndices() {
    for (int i = 0; i < _stops.length; i++) {
      _stops[i] = _stops[i].copyWith(stopOrder: i);
    }
  }

  void setStopLength(int index, int length) {
    if (index >= 0 && index < _stops.length) {
      _stops[index] = _stops[index].copyWith(lengthStay: length);
      _recalculateDayIndices();
      notifyListeners();
    }
  }

  void clearStops() {
    _stops.clear();
    notifyListeners();
  }
}