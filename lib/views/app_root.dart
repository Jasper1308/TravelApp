import 'package:flutter/material.dart';
import 'package:travel_app/views/screens/my_travels_screen.dart';
import 'package:travel_app/views/screens/preferences_screen.dart';
import 'package:travel_app/views/screens/profile_screen.dart';
import 'package:travel_app/views/screens/travel_form.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int selectedRoute = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: selectedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          MyTravelsScreen(),
          PreferencesScreen(),
          ProfileScreen(),
          TravelForm(),
        ],
      ),
    );
  }
}

