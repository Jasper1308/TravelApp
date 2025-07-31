import 'package:flutter/material.dart';
import 'package:travel_app/presentation/screens/my_travels_screen.dart';
import 'package:travel_app/presentation/screens/preferences_screen.dart';
import 'package:travel_app/presentation/screens/profile_screen.dart';
import 'package:travel_app/presentation/screens/travel_screen.dart';

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
    pc = PageController(initialPage: selectedRoute);
    super.initState();
  }

  setPage(page) {
    setState(() {
      selectedRoute = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPage,
        children: [
          MyTravelsScreen(),
          TravelForm(),
          ProfileScreen(),
          PreferencesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedRoute,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Minhas Viagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Nova Viagem'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Preferências',
          ),
        ],
        onTap: (index) {
          pc.animateToPage(
            index,
            duration: Duration(microseconds: 400),
            curve: Curves.ease,
          );
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey[800],
        showUnselectedLabels: true,
      ),
    );
  }
}
