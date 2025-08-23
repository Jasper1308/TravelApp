import 'package:flutter/material.dart';
import 'package:travel_app/presentation/screens/participant_register_screen.dart';
import 'package:travel_app/presentation/screens/travel_register_screen.dart';
import 'package:travel_app/presentation/screens/travel_stop_register_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
    '/participant-register': (context) => const ParticipantRegister(),
    '/travel-stop-register': (context) => const TravelStopRegisterScreen(),
    '/travel-register' : (context) => const TravelForm()
  };
}
