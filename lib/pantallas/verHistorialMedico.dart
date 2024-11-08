import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistorialMedicoScreen extends StatefulWidget {
  final int pacienteId;

  HistorialMedicoScreen({required this.pacienteId});

  @override
  _HistorialMedicoScreenState createState() => _HistorialMedicoScreenState();
}

class _HistorialMedicoScreenState extends State<HistorialMedicoScreen> {
  List<dynamic> historial = [];

  @override
  void initState() {
    super.initState();
    fetchHistorial();
  }

  Future<void> fetchHistorial() async {
    final response = await http.get(
      Uri.parse("http://localhost:5125/api/HistorialMedico/${widget.pacienteId}"),
    );
    if (response.statusCode == 200) {
      setState(() {
        historial = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historial Médico")),
      body: ListView.builder(
        itemCount: historial.length,
        itemBuilder: (context, index) {
          final registro = historial[index];
          return ListTile(
            title: Text("Fecha: ${registro['fecha']}"),
            subtitle: Text("Diagnóstico: ${registro['diagnostico']}"),
          );
        },
      ),
    );
  }
}
