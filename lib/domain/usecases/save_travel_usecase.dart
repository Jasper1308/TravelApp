import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/domain/usecases/create_travel_usecase.dart';

class SaveTravelUseCase {
  final CreateTravelUseCase _createTravel;

  SaveTravelUseCase(this._createTravel);

  Future<int> call({
    required String name,
    required DateTime? initialDate,
    required DateTime? endDate,
    required TransportType transportType,
    required List<TravelStop> stops,
    required List<Participant> participants,
  }) async {
    if (name.trim().isEmpty) throw Exception('Nome obrigatório');
    if (initialDate == null || endDate == null)
      throw Exception('Período inválido');

    final travel = Travel(
      travelId: 0,
      name: name,
      initialDate: initialDate,
      endDate: endDate,
      transportType: transportType,
    );

    return await _createTravel.call(travel, stops, participants);
  }
}