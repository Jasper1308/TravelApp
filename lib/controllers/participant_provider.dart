import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/participant.dart';

class ParticipantState extends ChangeNotifier{
  final List<Participant> participants = [];

  void addParticipant(Participant participant){
    participants.add(participant);
    notifyListeners();
  }

  void removeParticipant(Participant participant){
    participants.remove(participant);
    notifyListeners();
  }
}