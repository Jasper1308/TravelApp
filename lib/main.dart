import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/app_root.dart';
import 'package:travel_app/controllers/app_preferences_provider.dart';
import 'package:travel_app/core/theme/app_theme.dart';
import 'package:travel_app/views/screens/travel_stop_screen.dart';

import 'controllers/travel_provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TravelState()),
        ChangeNotifierProvider(create: (context) => AppPreferencesState())
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

      initialRoute: '/',
      routes: {
        '/': (context) => AppRoot(),
        '/travel_stop': (context) => TravelStopScreen(),
      },
    );
  }
}
