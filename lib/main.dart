import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/auth_gate.dart';
import 'package:travel_app/core/navigation/app_router.dart';
import 'package:travel_app/core/theme/app_theme.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/app_preferences_provider.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/providers/travel_stop_provider.dart';
import 'package:travel_app/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ServiceLocator().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppPreferencesState()),
        ChangeNotifierProvider(
          create: (_) => TravelProvider(
            ServiceLocator().listTravelsUC,
            ServiceLocator().removeTravelUC,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ParticipantProvider(
            ServiceLocator().createParticipantUC,
            ServiceLocator().listParticipantsUC,
            ServiceLocator().removeParticipantUC,
            ServiceLocator().associateParticipantWithTravelUC,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TravelStopProvider(
            ServiceLocator().addStopUC,
            ServiceLocator().reorderStopsUC,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TravelRegisterProvider(
            ServiceLocator().createTravelUC,
            ServiceLocator().addStopUC,
            ServiceLocator().getStopDateUseCase,
            ServiceLocator().reorderStopsUC,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesState = Provider.of<AppPreferencesState>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: preferencesState.themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale(preferencesState.language),
      supportedLocales: const [Locale('en'), Locale('es'), Locale('pt')],
      home: AuthGate(),
      routes: AppRouter.routes,
    );
  }
}
