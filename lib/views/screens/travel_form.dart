import 'package:flutter/material.dart';

class TravelForm extends StatefulWidget {
  const TravelForm({super.key});

  @override
  State<TravelForm> createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Viagem'),
        centerTitle: true,
      ),
    );
  }
}
