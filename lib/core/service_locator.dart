import 'package:travel_app/database/database.dart';
import 'package:travel_app/database/repositories/participant_repository.dart';
import 'package:travel_app/database/repositories/travel_repository.dart';
import 'package:travel_app/database/repositories/travel_stop_repository.dart';
import 'package:travel_app/domain/usecases/add_stop_usecase.dart';
import 'package:travel_app/domain/usecases/associate_participant_with_travel_usecase.dart';
import 'package:travel_app/domain/usecases/create_participant_usecase.dart';
import 'package:travel_app/domain/usecases/create_travel_usecase.dart';
import 'package:travel_app/domain/usecases/get_stop_date_usecase.dart';
import 'package:travel_app/domain/usecases/get_travel_with_details_usecase.dart';
import 'package:travel_app/domain/usecases/list_participants_usecase.dart';
import 'package:travel_app/domain/usecases/list_travel_usecase.dart';
import 'package:travel_app/domain/usecases/reorder_stop_usecase.dart';
import 'package:travel_app/domain/usecases/remove_participant_usecase.dart';
import 'package:travel_app/domain/usecases/remove_travel_usecase.dart';
import 'package:travel_app/domain/usecases/update_stops_day_index_usecase.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  final TravelAppDatabase db = TravelAppDatabase();

  late final TravelRepositoryImpl travelRepo;
  late final TravelStopRepositoryImpl stopRepo;
  late final ParticipantRepositoryImpl participantRepo;

  late final CreateTravelUseCase createTravelUC;
  late final ListTravelsUseCase listTravelsUC;
  late final RemoveTravelUseCase removeTravelUC;
  late final AddStopUseCase addStopUC;
  late final CreateParticipantUseCase createParticipantUC;
  late final ListParticipantsUseCase listParticipantsUC;
  late final ReorderStopsUseCase reorderStopsUC;
  late final UpdateStopsDayIndexUseCase updateStopsDayIndexUC;
  late final RemoveParticipantUseCase removeParticipantUC;
  late final GetStopDateUseCase getStopDateUseCase;
  late final AssociateParticipantWithTravelUseCase associateParticipantWithTravelUC;
  late final GetTravelWithDetailsUseCase getTravelDetailsUseCase;

  Future<void> init() async {
    travelRepo = TravelRepositoryImpl(db);
    stopRepo = const TravelStopRepositoryImpl();
    participantRepo = ParticipantRepositoryImpl(db);

    createTravelUC = CreateTravelUseCase(
      travelRepo,
      stopRepo,
      participantRepo,
      db.getDatabase(),
    );
    listTravelsUC = ListTravelsUseCase(travelRepo);
    removeTravelUC = RemoveTravelUseCase(travelRepo);
    addStopUC = AddStopUseCase();
    createParticipantUC = CreateParticipantUseCase(participantRepo, db);
    listParticipantsUC = ListParticipantsUseCase(participantRepo);
    reorderStopsUC = ReorderStopsUseCase();
    updateStopsDayIndexUC = UpdateStopsDayIndexUseCase();
    removeParticipantUC = RemoveParticipantUseCase(participantRepo);
    getStopDateUseCase = GetStopDateUseCase();
    associateParticipantWithTravelUC = AssociateParticipantWithTravelUseCaseImpl(travelRepo, db.getDatabase());
    getTravelDetailsUseCase = GetTravelWithDetailsUseCase(travelRepo);
  }
}