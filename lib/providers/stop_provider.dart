import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';

class StopState extends ChangeNotifier{
  final List<TravelStop> stops = [];

  void addStop(TravelStop stop){
    stops.add(stop);
    notifyListeners();
  }

  void removeStop(TravelStop stop){
    stops.remove(stop);
    notifyListeners();
  }
}