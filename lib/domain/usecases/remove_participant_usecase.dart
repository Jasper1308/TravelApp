import 'package:travel_app/domain/repositories/participant_repository.dart';

class RemoveParticipantUseCase {
  final ParticipantRepository repository;
  RemoveParticipantUseCase(this.repository);

  Future<void> call(int participantId) async {
    await repository.delete(participantId);
  }
}