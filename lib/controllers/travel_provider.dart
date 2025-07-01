import 'package:flutter/material.dart';
import 'package:travel_app/models/entities/travel.dart';
import 'package:travel_app/models/entities/travel_stop.dart';

class TravelState extends ChangeNotifier{
  final List<Travel> travels = [];
  final List<TravelStop> stops = [];

  void addTravel(Travel travel){
    travels.add(travel);
    notifyListeners();
  }

  void addStop(TravelStop stop){
    stops.add(stop);
    notifyListeners();
  }

  void removeTravel(Travel travel){
    travels.remove(travel);
    notifyListeners();
  }

  void removeStop(TravelStop stop){
    stops.remove(stop);
    notifyListeners();
  }




}