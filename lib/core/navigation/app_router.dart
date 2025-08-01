import 'package:flutter/material.dart';
import 'package:travel_app/presentation/screens/participant_register_screen.dart';
import 'package:travel_app/presentation/screens/travel_stop_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
    '/participant-register': (context) => const ParticipantRegister(),
    '/travel-stop-register': (context) => const TravelStopScreen(),
  };
}
