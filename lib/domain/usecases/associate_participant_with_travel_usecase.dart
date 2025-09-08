import 'package:travel_app/domain/repositories/travel_repository.dart';

abstract class AssociateParticipantWithTravelUseCase {
  Future<void> call(int participantId, int travelId);
}

class AssociateParticipantWithTravelUseCaseImpl
    implements AssociateParticipantWithTravelUseCase {
  final TravelRepository _travelRepository;

  AssociateParticipantWithTravelUseCaseImpl(this._travelRepository);

  @override
  Future<void> call(int participantId, int travelId) async {
    return await _travelRepository.associateParticipantWithTravel(
      participantId,
      travelId,
    );
  }
}
