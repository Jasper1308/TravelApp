import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/presentation/widgets/travel_card.dart';

class MyTravelsScreen extends StatelessWidget {
  const MyTravelsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TravelProvider>();
    final travels = provider.travels;
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Viagens'), centerTitle: true),
      body: travels.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.travel_explore, size: 56), SizedBox(height: 12), Text('Nenhuma viagem')]))
          : ListView.builder(
        itemCount: travels.length,
        itemBuilder: (_, i) => TravelCard(travel: travels[i]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, '/travel-register'), child: const Icon(Icons.add)),
    );
  }
}
