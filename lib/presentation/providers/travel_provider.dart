import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/controller/travel_controller.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/andress_formatter.dart';

class TravelState extends ChangeNotifier{
  final TravelController _travelController = TravelController();
  List<Travel> _travels = [];
  List<TravelStop> _stops = [];

  List<Travel> get travels => _travels;
  List<TravelStop> get stops => _stops;

  TravelState(){
    listTravels();
  }


  void addStop(TravelStop stop) async {
    final response = await NominatimService.reverseGeocode(stop.cordinates);
    stop.placeName = formatStopAndress(response.address!);
    _stops.add(stop);
    notifyListeners();
  }

  void removeStop(TravelStop stop){
    _stops.remove(stop);
    notifyListeners();
  }

  Future<void> createTravel(Travel travel) async{
    travel.stops = _stops;
    await _travelController.create(travel);
    _stops.clear();
    await listTravels();
  }

  Future<void> removeTravel(Travel travel) async{
    await _travelController.delete(travel.travelId);
    await listTravels();
  }

  Future<void> listTravels() async {
    _travels = await _travelController.listAll();
    notifyListeners();
  }

  void updateStopOrder(int oldIndex, int newIndex){
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final TravelStop movedStop = stops.removeAt(oldIndex);
    movedStop.stopOrder = newIndex;
    stops.insert(newIndex, movedStop);
    notifyListeners();
  }
}