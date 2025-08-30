import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/repository/travel_repository.dart';

class TravelState extends ChangeNotifier{
  List<Travel> travels = [];
  final List<TravelStop> stops = [];


  void addStop(TravelStop stop){
    stops.add(stop);

    notifyListeners();
  }

  void removeStop(TravelStop stop){
    stops.remove(stop);
    notifyListeners();
  }

  void addTravel(Travel travel){
    travel.stops = stops;
    stops.clear();
    travels.add(travel);
    TravelController().insert(travel);
    notifyListeners();
  }

  void removeTravel(Travel travel){
    travels.remove(travel);
    notifyListeners();
  }

  void listTravel() async {
    travels = await TravelController().list();
    notifyListeners();
  }

  void updateStopOrder(int oldIndex, int newIndex){
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final TravelStop movedStop = stops.removeAt(oldIndex);
    stops.insert(newIndex, movedStop);
    notifyListeners();
  }
}