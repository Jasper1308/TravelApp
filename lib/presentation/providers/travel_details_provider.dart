import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel_with_details.dart';
import 'package:travel_app/domain/usecases/get_travel_with_details_usecase.dart';

class TravelDetailsProvider extends ChangeNotifier {
  final GetTravelWithDetailsUseCase _getTravelWithDetails;

  TravelDetailsProvider(this._getTravelWithDetails);

  TravelWithDetails? _details;
  bool _loading = false;

  TravelWithDetails? get details => _details;
  bool get loading => _loading;

  Future<void> load(int travelId) async {
    _loading = true;
    notifyListeners();

    _details = await _getTravelWithDetails(travelId);

    _loading = false;
    notifyListeners();
  }
}
