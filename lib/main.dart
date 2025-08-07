import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/auth_gate.dart';
import 'package:travel_app/providers/app_preferences_provider.dart';
import 'package:travel_app/providers/participant_provider.dart';
import 'package:travel_app/core/navigation/app_router.dart';
import 'package:travel_app/core/theme/app_theme.dart';
import 'package:travel_app/firebase_options.dart';
import 'providers/travel_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TravelState()),
        ChangeNotifierProvider(create: (context) => AppPreferencesState()),
        ChangeNotifierProvider(create: (context) => ParticipantState()),
      ],
      child: MyApp(),
    )
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

      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      locale: Locale(preferencesState.language),
      supportedLocales: [Locale('en'), Locale('es'), Locale('pt')],

      home: AuthGate(),
      routes: AppRouter.routes

    );
  }
}
