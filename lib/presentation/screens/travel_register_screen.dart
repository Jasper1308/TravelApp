import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';
import 'package:travel_app/presentation/widgets/stop_list.dart';

class TravelRegisterScreen extends StatelessWidget {
  const TravelRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final register = context.watch<TravelRegisterProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                initialValue: register.name,
                decoration: const InputDecoration(labelText: 'Nome da viagem'),
                onChanged: (v) => context.read<TravelRegisterProvider>().setBasic(name: v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TransportType>(
                value: register.transport,
                decoration: const InputDecoration(labelText: 'Transporte'),
                items: TransportType.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                    .toList(),
                onChanged: (t) => context.read<TravelRegisterProvider>().setBasic(transportType: t),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DateInputField(
                      label: 'Início',
                      onDateSelected: (d) => context.read<TravelRegisterProvider>().setBasic(start: d),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateInputField(
                      label: 'Término',
                      onDateSelected: (d) => context.read<TravelRegisterProvider>().setBasic(end: d),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(height: 320, child: const StopList()),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final id = await context.read<TravelRegisterProvider>().save();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viagem criada (#\$id)')));
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text('Salvar viagem'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
