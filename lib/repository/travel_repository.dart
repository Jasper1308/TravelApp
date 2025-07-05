import 'package:travel_app/database/experiences_table.dart';
import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/database/travel_participant_table.dart';
import 'package:travel_app/database/travel_stop_table.dart';
import 'package:travel_app/models/entities/travel.dart';
import '../database/travel_table.dart';
import 'package:travel_app/database/database.dart';

class TravelController {
  Future<void> save(Travel travel) async {
    final db = await TravelAppDatabase().getDatabase();
    final travelMap = TravelTable.toMap(travel);
    await db.insert(TravelTable.tableName, travelMap);

    List<Map<String, dynamic>> participantMaps;
    for(final participant in travel.participants){
      participantMaps.add(ParticipantTable.toMap(participant));
    }

    final travelParticipantTable = TravelParticipantTable.toMap(travel);

    final experiencesTable = ExperiencesTable.toMap(travel.experiences);
  }

  Future<List<Travel>> list() async{
    final db = await TravelAppDatabase().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(TravelTable.tableName);
    var list = <Travel>[];
    for(final travel in result){
      list.add(
        Travel(
            travelId: travel[TravelTable.travelId],
            name: travel[TravelTable.name],
            initialDate: travel[TravelTable.initialDate],
            endDate: travel[TravelTable.endDate],
            transportType: travel[TravelTable.transportType],
            experiences: ,
            stops: travel[TravelSt],
            participants: participants
        )
      );
    }
  }
}