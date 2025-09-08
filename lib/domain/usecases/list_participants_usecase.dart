import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';

class ListParticipantsUseCase {
  final ParticipantRepository _repo;
  ListParticipantsUseCase(this._repo);
  Future<List<Participant>> call() {
    return _repo.listAll();
  }
}