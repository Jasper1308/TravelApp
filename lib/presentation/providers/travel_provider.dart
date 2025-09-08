import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/usecases/list_travel_usecase.dart';
import 'package:travel_app/domain/usecases/remove_travel_usecase.dart';

class TravelProvider extends ChangeNotifier {
  final ListTravelsUseCase _listTravels;
  final RemoveTravelUseCase _removeTravel;

  TravelProvider(this._listTravels, this._removeTravel);

  List<Travel> _travels = [];

  List<Travel> get travels => List.unmodifiable(_travels);

  Future<void> loadTravels() async {
    _travels = await _listTravels();
    notifyListeners();
  }

  Future<void> removeTravel(int travelId) async {
    await _removeTravel(travelId);
    await loadTravels();
  }
}
