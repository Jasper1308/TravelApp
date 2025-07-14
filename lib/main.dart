import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/app_root.dart';
import 'package:travel_app/views/screens/travel_stop_screen.dart';

import 'controllers/travel_provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => TravelState(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es'), Locale('pt')],
      initialRoute: '/',
      routes: {
        '/': (context) => AppRoot(),
        '/travel_stop': (context) => TravelStopScreen(),
      },
    );
  }
}
