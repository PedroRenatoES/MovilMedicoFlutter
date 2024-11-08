import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerCitasScreen extends StatefulWidget {
  final int pacienteId;

  VerCitasScreen({required this.pacienteId});

  @override
  _VerCitasScreenState createState() => _VerCitasScreenState();
}

class _VerCitasScreenState extends State<VerCitasScreen> {
  List<dynamic> citas = [];

  @override
  void initState() {
    super.initState();
    fetchCitas();
  }

  Future<void> fetchCitas() async {
    final response = await http.get(
      Uri.parse("http://localhost:5125/api/Citas/ver/${widget.pacienteId}"),
    );
    if (response.statusCode == 200) {
      setState(() {
        citas = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Citas")),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          final cita = citas[index];
          return ListTile(
            title: Text(cita['motivo']),
            subtitle: Text("Fecha: ${cita['fechaHora']} - Estado: ${cita['estado']}"),
          );
        },
      ),
    );
  }
}
