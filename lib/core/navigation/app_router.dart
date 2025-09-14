import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/service_locator.dart';
import 'package:travel_app/presentation/providers/travel_details_provider.dart';
import 'package:travel_app/presentation/screens/participant_register_screen.dart';
import 'package:travel_app/presentation/screens/travel_details_screen.dart';
import 'package:travel_app/presentation/screens/travel_register_screen.dart';
import 'package:travel_app/presentation/screens/travel_stop_register_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
    '/participant-register': (context) => const ParticipantRegisterScreen(),
    '/travel-stop-register': (context) => const TravelStopRegisterScreen(),
    '/travel-register' : (context) => const TravelRegisterScreen(),
    '/travel-details': (context) {
      final travelId = ModalRoute.of(context)!.settings.arguments as int;
      return ChangeNotifierProvider<TravelDetailsProvider>(
        create: (context) => TravelDetailsProvider(
          ServiceLocator().getTravelDetailsUseCase,
        ),
        child: TravelDetailsScreen(travelId: travelId),
      );
    },

  };
}
