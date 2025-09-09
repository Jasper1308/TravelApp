import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/presentation/widgets/travel_card.dart';

class MyTravelsScreen extends StatefulWidget {
  const MyTravelsScreen({super.key});

  @override
  State<MyTravelsScreen> createState() => _MyTravelsScreenState();
}

class _MyTravelsScreenState extends State<MyTravelsScreen> {
  bool _isInitialLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialLoad) {
      context.read<TravelProvider>().loadTravels();
      _isInitialLoad = false;
    }
  }

  @override
  void dispose() {
    _isInitialLoad = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TravelProvider>();
    final travels = provider.travels;

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Viagens'), centerTitle: true),
      body: travels.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.travel_explore, size: 56),
            SizedBox(height: 12),
            Text('Nenhuma viagem'),
          ],
        ),
      )
          : ListView.builder(
        itemCount: travels.length,
        itemBuilder: (_, i) => TravelCard(
          travel: travels[i],
          onTap: () {
            Navigator.pushNamed(
              context,
              '/travel-details',
              arguments: travels[i].travelId,
            ).then((_) {
              context.read<TravelProvider>().loadTravels();
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/travel-register').then((result) {
            if (result != null) {
              context.read<TravelProvider>().loadTravels();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}