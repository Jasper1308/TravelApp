import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';

class TravelState extends ChangeNotifier{
  final List<Travel> travels = [];
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
    travels.add(travel);
    notifyListeners();
  }

  void removeTravel(Travel travel){
    travels.remove(travel);
    notifyListeners();
  }
}