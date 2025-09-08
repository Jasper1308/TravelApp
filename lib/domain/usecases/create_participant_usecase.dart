import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/repositories/participant_repository.dart';
import 'package:travel_app/database/database.dart';

class CreateParticipantUseCase {
  final ParticipantRepository repository;
  final TravelAppDatabase db;

  CreateParticipantUseCase(this.repository, this.db);

  Future<int> call(Participant participant) async {
    if (participant.name.isEmpty) {
      throw Exception("Nome não pode ser vazio");
    }
    final database = await db.getDatabase();
    return await repository.insertOrUpdate(database, participant);
  }
}
